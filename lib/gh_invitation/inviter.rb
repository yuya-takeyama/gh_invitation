module GhInvitation
  class Inviter
    def initialize(octokit, organization)
      @octokit = octokit
      @organization = organization
    end

    def invite(username)
      @octokit.update_organization_membership(
        @organization,
        user: username,
      )
    end
  end
end
