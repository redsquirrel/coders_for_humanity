class Collaboration < ActiveRecord::Base
  attr_accessible :developer_id, :project_id, :role_id

  belongs_to :project
  belongs_to :developer
  belongs_to :role

  before_create :set_role, :send_request_email

  def pending?
    role.description == 'pending'
  end

  def set_role
    self.role_id = Role.where(:description => 'pending').first_or_create.id
  end

  def send_request_email
    UserMailer.collaboration_request_notice(:idea_owner => project.creator, :developer => developer).deliver
  end
end
