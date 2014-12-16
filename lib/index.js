(function() {
  var MediaLibraryClient, request, serializeQuery;

  request = require('superagent');

  serializeQuery = require('qs').stringify;

  MediaLibraryClient = (function() {
    function MediaLibraryClient(options) {
      this._baseUrl = options.baseUrl;
    }

    MediaLibraryClient.prototype.status = function(callback) {
      return request.get(this._baseUrl + '/status').end(function(err, res) {
        if (err) {
          return callback(err);
        }
        return callback(null, res.text);
      });
    };

    MediaLibraryClient.prototype.scan = function(callback) {
      return request.get(this._baseUrl + '/scan').end(function(err, res) {
        if (err) {
          return callback(err);
        }
        return callback(null, res.text);
      });
    };

    MediaLibraryClient.prototype.tracks = function(query, callback) {
      if (typeof query === 'function') {
        callback = query;
        query = {};
      }
      return request.get(this._baseUrl + '/tracks').query(serializeQuery(query)).end(function(err, res) {
        if (err) {
          return callback(err);
        }
        return callback(null, res.body);
      });
    };

    MediaLibraryClient.prototype.artists = function(query, callback) {
      if (typeof query === 'function') {
        callback = query;
        query = {};
      }
      return request.get(this._baseUrl + '/artists').query(serializeQuery(query)).end(function(err, res) {
        if (err) {
          return callback(err);
        }
        return callback(null, res.body);
      });
    };

    MediaLibraryClient.prototype.albums = function(query, callback) {
      if (typeof query === 'function') {
        callback = query;
        query = {};
      }
      return request.get(this._baseUrl + '/albums').query(serializeQuery(query)).end(function(err, res) {
        if (err) {
          return callback(err);
        }
        return callback(null, res.body);
      });
    };

    MediaLibraryClient.prototype.find = function(query, callback) {
      if (typeof query === 'function') {
        callback = query;
        query = {};
      }
      return request.get(this._baseUrl + '/find').query(serializeQuery(query)).end(function(err, res) {
        if (err) {
          return callback(err);
        }
        return callback(null, res.body);
      });
    };

    return MediaLibraryClient;

  })();

  module.exports = MediaLibraryClient;

}).call(this);
