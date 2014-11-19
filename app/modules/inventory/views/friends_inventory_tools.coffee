module.exports = class FriendsInventoryTools extends Backbone.Marionette.ItemView
  template: require './templates/friends_inventory_tools'
  events:
    'keyup #itemsTextFilterField': 'executeTextFilter'
    'click #itemsTextFilterButton': 'executeTextFilter'
    'keyup #userSearchField': 'executeFriendSearch'
    'click #userSearchButton': 'executeFriendSearch'
  serializeData: ->
    attrs =
      userSearch:
        nameBase: 'userSearch'
        field:
          placeholder: _.i18n 'Find Friends'
        button:
          classes: 'secondary'
          text: _.i18n 'Search Friends'

      itemsTextFilter:
        nameBase: 'itemsTextFilter'
        field:
          placeholder: _.i18n 'Find an object'
        button:
          classes: 'secondary'
          text: _.i18n 'Search'
    return attrs

  executeTextFilter: ->
    text = $('#itemsTextFilterField').val()
    Items.friends.filtered.filterByText text, false

  executeFriendSearch: ->
    app.execute 'userSearch', $('#userSearchField').val()