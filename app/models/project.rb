class Project < ActiveRecord::Base
  attr_accessible  :category_id, :creator_id, :description, :status, :story, :title

  include Workflow

  has_many :collaborations
  has_many :developers, :through => :collaborations
  belongs_to :creator, :class_name => "IdeaOwner"
  belongs_to :category

  validates_presence_of :title
  validates_presence_of :description

  scope :under_review, -> { where(workflow_state: "under_review")}
  scope :completed, -> { where(workflow_state: "complete") }
  scope :public, -> { where('workflow_state != ?', "under_review" ) }

  workflow do
    state :under_review do
      event :publish, transition_to: :not_yet_assigned
      event :reject, transition_to: :rejected
    end
    state :not_yet_assigned do
      event :assign, transition_to: :assigned
    end
    state :assigned do
      event :start, transition_to: :in_progress
    end
    state :in_progress do
      event :complete, transition_to: :completed
    end
    state :completed
  end

  def assign(collaboration)
    collaboration.role = Role.where(:description => "lead developer").first
    collaboration.save!

    Thread.new do
      UserMailer.notify_assignment_to_developer(:idea_owner => self.creator, :developer => collaboration.developer).deliver
    end

  end

  def pending_collaborations
    collaborations.joins(:role).where(:roles => {:description => 'pending'})
  end

  def assigned_developers
    assigned_collaborations.map(&:developer)
  end

  def assigned_collaborations
    collaborations.includes(:developer) - pending_collaborations
  end

  def category_name
    category.name
  end
end
