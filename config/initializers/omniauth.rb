Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "143996342320589", "bb7864a3d179a1710b08a400a1d34f9d"
  #provider :facebook, "126152287451118", "e8713067fd2fb2037d0e7f1414501ede"
end