request = require 'superagent'
# need to use this because superagent do not use it client size
# and it is not swappable
serializeQuery = require('qs').stringify

class MediaLibraryClient
  constructor: (options) ->
    @_baseUrl = options.baseUrl
    
  status: (callback) ->
    request
      .get(@_baseUrl + '/status')
      .end((err, res) ->
        return callback(err) if err
        callback(null, res.text)
      )
      
  scan: (callback) ->
    request
      .get(@_baseUrl + '/scan')
      .end((err, res) ->
        # console.log(res)
        return callback(err) if err
        callback(null, res.text)
      )
      
  tracks: (query, callback) ->
    if typeof(query) == 'function'
      callback = query
      query = {}
    request
      .get(@_baseUrl + '/tracks')
      .query(serializeQuery(query))
      .end((err, res) ->
        return callback(err) if err
        callback(null, res.body)
      )
      
  artists: (query, callback) ->
    if typeof(query) == 'function'
      callback = query
      query = {}
    request
      .get(@_baseUrl + '/artists')
      .query(serializeQuery(query))
      .end((err, res) ->
        return callback(err) if err
        callback(null, res.body)
      )
      
  albums: (query, callback) ->
    if typeof(query) == 'function'
      callback = query
      query = {}
    request
      .get(@_baseUrl + '/albums')
      .query(serializeQuery(query))
      .end((err, res) ->
        return callback(err) if err
        callback(null, res.body)
      )
      
  find: (query, callback) ->
    if typeof(query) == 'function'
      callback = query
      query = {}
    request
      .get(@_baseUrl + '/find')
      .query(serializeQuery(query))
      .end((err, res) ->
        return callback(err) if err
        callback(null, res.body)
      )

module.exports = MediaLibraryClient
