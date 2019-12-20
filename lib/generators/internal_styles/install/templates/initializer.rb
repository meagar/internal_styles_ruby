# frozen_string_literal: true
# Configuration for the Prodigy InternalStyles gem

# Remember to restart your application after changing this file.

InternalStyles.configure do |config|
  config.nav do |nav|
    # Items are in the form
    #  nav.item(label, icon, path)
    # Icons are from font-awesome v4

    # Top level navigation items go here.
    # nav.item('Users', 'user', users_path)
    # nav.item('Posts', 'mail', posts_path)

    if Rails.env.development?
      nav.sub_nav 'Development' do |sub_nav|
        sub_nav.item('Mail Previews', 'envelope', '/rails/mailers')
        sub_nav.item('Routes', 'road', '/rails/info/routes')
        sub_nav.item('Properties', 'gear', '/rails/info/Properties')
      end
    end

    nav.sub_nav 'External Services' do |sub_nav|
      # TODO: Update these links to reflect your own pipelines, repositories, etc.
      sub_nav.item('Github', 'github', 'https://github.com/SMARTeacher/prodigy-identity-service')
      sub_nav.item('Codacy', 'code', 'https://app.codacy.com/project/Prodigy-Game/prodigy-identity-service/dashboard')
      sub_nav.item('CircleCI', 'circle-o-notch', 'https://circleci.com/gh/SMARTeacher/prodigy-identity-service')
      sub_nav.item('DataDog APM', 'tv', 'https://app.datadoghq.com/apm/service/prodigy-identity-service/rack.request?end=1548777187569&env=production&paused=false')
      sub_nav.item('Health Dashboard', 'tv', 'https://app.datadoghq.com/dash/1064138/identity-health-dashboard?tile_size=m&page=0&is_auto=false&from_ts=1548990420000&to_ts=1548994020000&live=true')
      sub_nav.item('Sentry', 'bug', 'https://sentry.io/organizations/prodigygame/issues/?project=1512871')
      sub_nav.item('Staging AWS', 'amazon', 'https://smarteacher-staging.signin.aws.amazon.com/console')
      sub_nav.item('Dev AWS', 'amazon', 'https://prodigy-dev.signin.aws.amazon.com/console')
    end
  end
end
