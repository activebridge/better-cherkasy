betterCherkasy.factory 'actionsDecorator', [
  'Flash'
  'ModalService'
  (Flash, ModalService) ->
    ($scope) ->
      $scope.selected_action = 'Активні'
      $scope.actions = [
        {name: 'Активні'}
        {name: 'Завершені'}
        {name: 'Мої пропозиції'}
        {name: 'Нова пропозиція'}
      ]

      onNewEventModal = ->
        unless userSignedIn()
          Flash.create('warning', 'Для того щоб щось пропонувати ви маєте залогінитись', 'custom-class')

        ModalService.showModal(
          templateUrl: '/assets/modals/new_event.html.haml'
          controller: 'NewEventCtrl'
        ).then((modal) ->
          modal.element.show()
        )

      $scope.update = ->
        $scope.selected_action = @action.name
        switch @action.name
          when 'Активні' then console.log('Active')
          when 'Завершені' then console.log('Finished')
          when 'Мої пропозиції' then console.log('My events')
          when 'Нова пропозиція' then onNewEventModal()
]
