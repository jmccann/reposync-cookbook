actions :create
default_action :create

attribute :webroot, kind_of: String, default: node['nginx']['default_root']
attribute :path, kind_of: String, required: true

include Chef::DSL::Recipe
attr_accessor :yum_repo

def yum_repo(repositoryid = nil, &block)
  return @yum_repo unless block_given?
  return @yum_repo unless @yum_repo.nil?

  @yum_repo ||= yum_repository("#{@name}-yum_repo", &block)
  @yum_repo.repositoryid repositoryid unless repositoryid.nil?

  @yum_repo.enabled false
  @yum_repo.action :nothing
  @yum_repo
end
