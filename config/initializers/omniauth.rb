OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :openid_connect, {
    name: :ace_cloud,
    scope: [:openid, :email, :profile],
    response_type: :id_token,
    uid_field: "preferred_username",
    client_options: {
      port: 443,
      scheme: "https",
      host: "sso.uf-ace.com",
      identifier: ENV["OP_CLIENT_ID"],
      secret: ENV["OP_SECRET_KEY"],
      redirect_uri: "http://uf-ace.com/app/users/auth/openid_connect/callback",
    }
  }
end