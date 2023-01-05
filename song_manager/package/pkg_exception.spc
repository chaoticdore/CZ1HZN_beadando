CREATE OR REPLACE PACKAGE pkg_exception IS

  songs_already_exists EXCEPTION;
  gc_songs_already_exists CONSTANT NUMBER := -20000;
  PRAGMA EXCEPTION_INIT(songs_already_exists, -20000);

  band_not_found EXCEPTION;
  gc_band_not_found CONSTANT NUMBER := -20001;
  PRAGMA EXCEPTION_INIT(band_not_found, -20001);

  band_already_exists EXCEPTION;
  gc_band_already_exists CONSTANT NUMBER := -20002;
  PRAGMA EXCEPTION_INIT(band_already_exists, -20002);

  album_not_found EXCEPTION;
  gc_album_not_found CONSTANT NUMBER := -20003;
  PRAGMA EXCEPTION_INIT(album_not_found, -20003);

  album_already_exists EXCEPTION;
  gc_album_already_exists CONSTANT NUMBER := -20004;
  PRAGMA EXCEPTION_INIT(album_already_exists, -20004);

  publisher_not_found EXCEPTION;
  gc_publisher_not_found CONSTANT NUMBER := -20005;
  PRAGMA EXCEPTION_INIT(publisher_not_found, -20005);

  artist_already_exists EXCEPTION;
  gc_artist_already_exists CONSTANT NUMBER := -20006;
  PRAGMA EXCEPTION_INIT(artist_already_exists, -20006);

  genre_not_found EXCEPTION;
  gc_genre_not_found CONSTANT NUMBER := -20007;
  PRAGMA EXCEPTION_INIT(genre_not_found, -20007);

  genre_already_exists EXCEPTION;
  gc_genre_already_exists CONSTANT NUMBER := -20008;
  PRAGMA EXCEPTION_INIT(genre_already_exists, -20008);

  song_not_found EXCEPTION;
  gc_song_not_found CONSTANT NUMBER := -20009;
  PRAGMA EXCEPTION_INIT(song_not_found, -20009);

  artist_not_found EXCEPTION;
  gc_artist_not_found CONSTANT NUMBER := -20010;
  PRAGMA EXCEPTION_INIT(artist_not_found, -20010);
  
  publisher_already_exists EXCEPTION;
  gc_publisher_already_exists CONSTANT NUMBER := -20011;
  PRAGMA EXCEPTION_INIT(publisher_already_exists, -20011);
  
  connection_already_exists EXCEPTION;
  gc_connection_already_exists CONSTANT NUMBER := -20012;
  PRAGMA EXCEPTION_INIT(connection_already_exists, -20012);

END pkg_exception;
/
