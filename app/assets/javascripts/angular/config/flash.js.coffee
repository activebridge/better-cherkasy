etcFlashConfig = (flashProvider) ->
  flashProvider.errorClassnames.push 'alert-danger'

etcFlashConfig.$inject = ['flashProvider']
betterCherkasy.config etcFlashConfig

