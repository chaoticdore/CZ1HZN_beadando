INSERT INTO bands (id ,band_name)VALUES (1 ,'Imagine Dragons');
INSERT INTO bands (id, band_name)VALUES (2, 'X Ambbassadors');


INSERT INTO publishers (id ,publisher_name ,headquarters ,ceo_first_name ,ceo_last_name ,foundation_date)VALUES (1 ,'Kidinakorner' ,'Los Angeles, California' ,'Alexander' ,'Grant'
  ,to_date('2011', 'yyyy'));
  

INSERT INTO genres (id ,genre_name)VALUES (1 ,'pop rock');

INSERT INTO genres (id ,genre_name)VALUES (2 ,'electropop');

INSERT INTO genres (id ,genre_name)VALUES (3 ,'pop');

INSERT INTO genres (id ,genre_name)VALUES (4 ,'indie');

INSERT INTO genres (id ,genre_name)VALUES (5 ,'alternative rock');


INSERT INTO albums (id ,band_id ,album_name ,release_date ,publisher_id)VALUES (1 ,1 ,'Mercury Act 1' ,to_date('01-09-2022', 'dd-mm-yyyy') ,1);

INSERT INTO albums (id ,band_id ,album_name ,release_date ,publisher_id)VALUES (2 ,1 ,'Mercury Act 2' ,to_date('01-09-2022', 'dd-mm-yyyy') ,1);


INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (1 ,'Dan' ,'Reynolds' ,'Las Vegas, Nevada' ,to_date('14-07-1987', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (2 ,'Wayne' ,'Sermon' ,'American Fork, Utah' ,to_date('15-06-1987', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (3 ,'Ben' ,'McKee' ,'Forestville, California' ,to_date('07-04-1985', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (4 ,'Daniel' ,'Platzman' ,'Las Vegas, Nevada' ,to_date('28-09-1986', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (5 ,'Sam' ,'Harris' ,'Ithaca, New York' ,to_date('26-09-1988', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (6 ,'Casey' ,'Harris' ,'Ithaca, New York' ,to_date('09-01-1987', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (7 ,'Adam' ,'Levin' ,'Ithaca, New York' ,to_date('15-07-1988', 'dd-mm-yyyy'));

INSERT INTO artists (id ,first_name ,last_name ,birth_place ,birth_date)VALUES (8 ,'Russ' ,'Flynn' ,'Philadelphia, PA' ,to_date('16-04-1985', 'dd-mm-yyyy'));


INSERT INTO songs(id, album_id ,band_id ,song_name ,release_date ,song_length)VALUES (1 ,1 ,1 ,'Enemy(with JID)' ,to_date('28-10-2021', 'dd-mm-yyyy') ,173);

INSERT INTO songs (id ,album_id ,band_id ,song_name ,release_date ,song_length)VALUES (2 ,1 ,1 ,'My Life' ,to_date('01-09-2022', 'dd-mm-yyyy') ,224);

INSERT INTO songs (id ,album_id ,band_id ,song_name ,release_date ,song_length)VALUES (3 ,1 ,1 ,'Lonely' ,to_date('01-09-2022', 'dd-mm-yyyy') ,159);

INSERT INTO songs (id ,album_id ,band_id ,song_name ,release_date ,song_length)VALUES (4 ,1 ,1 ,'Wrecked' ,to_date('01-09-2022', 'dd-mm-yyyy') ,244);

INSERT INTO songs (id ,album_id ,band_id ,song_name ,release_date ,song_length)VALUES (5 ,1 ,1 ,'Monday' ,to_date('01-09-2022', 'dd-mm-yyyy') ,187);

INSERT INTO songs (id ,album_id ,band_id ,song_name ,release_date ,song_length)VALUES (6 ,2 ,1 ,'Bones' ,to_date('11-03-2022', 'dd-mm-yyyy') ,165);

INSERT INTO songs (id ,album_id ,band_id ,song_name ,release_date ,song_length)VALUES (7 ,2 ,1 ,'Symphony' ,to_date('11-03-2022', 'dd-mm-yyyy') ,175);


INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (1 ,1 ,1);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (2 ,2 ,1);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (3 ,3 ,1);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (4 ,4 ,1);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (5 ,5 ,2);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (6 ,6 ,2);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (7 ,7 ,2);

INSERT INTO artist_band_connections (id ,artist_id ,band_id)VALUES (8 ,8 ,2);


INSERT INTO genre_album_connections (id ,genre_id ,album_id)VALUES (1 ,1 ,1);

INSERT INTO genre_album_connections (id ,genre_id ,album_id)VALUES (2 ,4 ,2);

INSERT INTO genre_album_connections (id ,genre_id ,album_id)VALUES (3 ,5 ,2);

COMMIT;
