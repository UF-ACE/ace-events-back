OmniAuth.config.logger = Rails.logger

OmniAuth.config.full_host = lambda do |env|
  scheme         = env['rack.url_scheme']
  local_host     = env['HTTP_HOST']
  forwarded_host = env['HTTP_X_FORWARDED_HOST']
  forwarded_host.blank? ? "#{scheme}://#{local_host}" : "#{scheme}://#{forwarded_host}"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect, {
    name: :ace_cloud,
    scope: [:openid, :email, :profile],
    response_type: :code,
    discovery: true,
    issuer: 'https://sso.uf-ace.com/auth/realms/master',
    response_mode: :form_post,
    client_options: {
      port: 443,
      scheme: "https",
      host: "sso.uf-ace.com/auth/realms/master/protocol/openid-connect/auth",
      identifier: ENV["OP_CLIENT_ID"],
      secret: ENV["OP_SECRET_KEY"],
      redirect_uri: "http://localhost/auth/ace_cloud/callback",
    }
  }
end