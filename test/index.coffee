should = require 'should'
mediaLibraryServer = require 'media-library-server'
MediaLibraryClient = require '../lib/'

config =
  dataPath: './test/'
  paths: ['./test/']
  disableLogs: true

describe('client', () ->
  
  app = mediaLibraryServer.standalone(config)
  client = new MediaLibraryClient(baseUrl: 'http://localhost:4000')
  server = null
  
  before((done) ->
    server = app.listen(4000, ->
      done()
    )
  )
  
  after(->
    server.close()
  )

  describe('#status()', () ->
    it('returns online', (done) ->
      client.status((err, status) ->
        return done(err) if err
        status.should.equal('online')
        done()
      )
    )
  )

  describe('#scan()', () ->
    it('respond with tracks and total', (done) ->
      client.scan((err, res) ->
        return done(err) if err
        lines = res.split('\n')
        # chunks not supported by superagent atm
        # see: https://github.com/visionmedia/superagent/issues/482
        lines.should.have.lengthOf(1)
        lines[0].should.equal('scanned tracks: 0')
        done()
      )
    )
  )

  describe('#tracks()', () ->
    it('respond with all tracks', (done) ->
      client.tracks((err, tracks) ->
        return done(err) if err
        tracks.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(2)
        done()
      )
    )
    
    it('filter results with query param', (done) ->
      client.tracks({artist: 'Placebo'}, (err, tracks) ->
        return done(err) if err
        tracks.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(1)
        done()
      )
    )
  )

  describe('#artists()', () ->
    it('respond with all artists', (done) ->
      client.artists((err, artists) ->
        return done(err) if err
        artists.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(2)
        done()
      )
    )
    
    it('filter results with query param', (done) ->
      client.artists({artist: 'Placebo'}, (err, artists) ->
        return done(err) if err
        artists.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(1)
        done()
      )
    )
  )

  describe('#albums()', () ->
    it('respond with all albums', (done) ->
      client.albums((err, albums) ->
        return done(err) if err
        albums.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(2)
        done()
      )
    )
    
    it('filter results with query param', (done) ->
      client.albums({artist: 'Placebo'}, (err, albums) ->
        return done(err) if err
        albums.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(1)
        done()
      )
    )
  )

  describe('#find()', () ->
    it('respond with all tracks', (done) ->
      client.find((err, tracks) ->
        return done(err) if err
        tracks.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(2)
        done()
      )
    )
    
    it('filter results with query param', (done) ->
      client.find({artist: 'Plac'}, (err, tracks) ->
        return done(err) if err
        tracks.should
          .be.instanceOf(Array)
          .and.have.have.lengthOf(1)
        done()
      )
    )
  )

)
