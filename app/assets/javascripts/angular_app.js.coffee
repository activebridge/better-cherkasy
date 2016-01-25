@betterCherkasy = angular.module('betterCherkasy', [
  'ui.bootstrap'
  'ngRoute'
  'ngResource'
  'ngFacebook'
  'flash'
  'ngCookies'
  'ngTagsInput'
  'ckeditor'
  'ngSanitize'
  'angularFileUpload'
])


betterCherkasy.run ['$rootScope', ($rootScope) ->
  $rootScope.Configuration =
    baseUrl: '/'

  # Load the facebook SDK asynchronously
  (->

    # If we've already installed the SDK, we're done
    return  if document.getElementById('facebook-jssdk')

    # Get the first script element, which we'll use to find the parent node
    firstScriptElement = document.getElementsByTagName('script')[0]

    # Create a new script element and set its id
    facebookJS = document.createElement('script')
    facebookJS.id = 'facebook-jssdk'

    # Set the new script's source to the source of the Facebook JS SDK
    facebookJS.src = '//connect.facebook.net/en_US/all.js'

    # Insert the Facebook JS SDK into the DOM
    firstScriptElement.parentNode.insertBefore facebookJS, firstScriptElement
    return
  )()
  return
]

