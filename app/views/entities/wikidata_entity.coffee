module.exports =  class WikidataEntity extends Backbone.Marionette.LayoutView
  template: require 'views/entities/templates/wikidata_entity'
  regions:
    article: '#article'
    items: '#items'
  behaviors:
    PreventDefault: {}

  initialize: ->
    app.entity = @
    @listenTo @model, 'add:pictures', @render
    @fetchPublicItems()

  onRender: -> @showPublicItems()

  events:
    'click #addToInventory': 'showItemCreationForm'
    'click #toggleWikiediaPreview': 'toggleWikiediaPreview'
    'click #toggleDescLength': 'toggleDescLength'

  fetchPublicItems: ->
    app.request 'get:entity:public:items', @model.get('uri')
    .done (itemsData)=>
      items = new app.Collection.Items(itemsData)
      @items.viewCollection = items
      @showPublicItems()

  showPublicItems: ->
    items = @items.viewCollection
    _.log items, 'items????'
    if items?.length > 0
        itemList = new app.View.ItemsList {collection: items}
    else
      itemList = new app.View.ItemsList
    @items.show itemList

  showItemCreationForm: ->
    app.execute 'show:item:creation:form', {entity: @model}
    url = @model.get('pathname') + '/add'
    app.navigate url

  toggleWikiediaPreview: ->
    $article = $('#wikipedia-article')
    mobileUrl = @model.get 'wikipedia.mobileUrl'
    if $article.find('iframe').length is 0
      iframe = "<iframe class='wikipedia' src='#{mobileUrl}' frameborder='0'></iframe>"
      $article.html iframe
      $article.slideDown()
    else
      $article.slideToggle()


    $('#toggleWikiediaPreview').find('i').toggleClass('hidden')

  toggleDescLength: ->
    $('#shortDesc').toggle()
    $('#fullDesc').toggle()
    $('#toggleDescLength').find('i').toggleClass('hidden')
