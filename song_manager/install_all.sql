PROMPT Installing DB...

--Sequence installation
PROMPT Installing sequences...

@./sequence/song_manager_sequences.sql

--Table installation
PROMPT Installing tables...

@./table/songs.sql
@./table/albums.sql
@./table/artists.sql
@./table/genres.sql
@./table/publishers.sql
@./table/bands.sql
@./table/artist_band_connections.sql
@./table/genre_album_connections.sql

--History table installation
PROMPT Installing history tables...

@./table/songs_h.sql
@./table/albums_h.sql
@./table/artists_h.sql
@./table/genres_h.sql
@./table/publishers_h.sql
@./table/bands_h.sql

--Altering base tables for history 
PROMPT Altering tables with history columns...

@./alter/alter_for_history.sql


-- Type installation
PROMPT Installing types...
@./type/ty_songs_in_album_l.tps
@./type/ty_songs_by_album.typ

--Package installation
PROMPT Installing packages...

@./package/pkg_exception.spc
@./package/pkg_publishers.pck
@./package/pkg_bands.pck
@./package/pkg_songs.pck
@./package/pkg_genres.pck
@./package/pkg_albums.pck
@./package/pkg_genres.pck
@./package/pkg_albums.pck

-- View installation
PROMPT Installing views...

@./view/vw_all_songs.sql
@./view/vw_band_members.sql
@./view/vw_songs.sql
@./view/vw_albums.sql
@./view/vw_artists.sql
@./view/vw_publishers.sql
@./view/vw_genres.sql
@./view/vw_bands.sql
@./view/vw_bands_albums_by_publishers.sql

-- Trigger installation
PROMPT Installing triggers...

@./trigger/trg_albums.trg
@./trigger/trg_albums_h.trg
@./trigger/trg_artists.trg
@./trigger/trg_artists_h.trg
@./trigger/trg_bands.trg
@./trigger/trg_bands_h.trg
@./trigger/trg_genres.trg
@./trigger/trg_genres_h.trg
@./trigger/trg_publishers.trg
@./trigger/trg_publishers_h.trg
@./trigger/trg_songs.trg
@./trigger/trg_songs_h.trg
@./trigger/trg_artist_band_connections.trg
@./trigger/trg_genre_album_connections.trg

-- Recompile schema
BEGIN
  dbms_utility.compile_schema(schema => 'SONG_MANAGER');
END;
/

--Adding foreign keys and constraints
PROMPT Adding constraints, foreign keys...

@./alter/alter_songs.sql
@./alter/alter_albums.sql
@./alter/alter_artist_band_connections.sql
@./alter/alter_genre_album_connections.sql

-- Mock data load
PROMPT Loading tables with data...
@./insert/insert_mock_data.sql

PROMPT Done.

EXIT
