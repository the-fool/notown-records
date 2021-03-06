drop table musician_performs_song;
drop table musician_plays_instrument;
drop sequence m_seq;
drop table songs;
drop table albums;
drop sequence album_seq;
drop table musicians;
drop table addresses;
drop sequence song_seq;
drop table instruments;
drop sequence instr_seq;

CREATE TABLE addresses
(
	address VARCHAR2(127) NOT NULL,
	phone NUMBER NOT NULL,
	CONSTRAINT address_pk PRIMARY KEY(address),
	CONSTRAINT phone_unq UNIQUE (phone)
);

CREATE TABLE musicians
(
	ssn NUMBER NOT NULL,
	m_name VARCHAR(127) NOT NULL,
	m_address VARCHAR(127),
	CONSTRAINT m_pk PRIMARY KEY(ssn),
	CONSTRAINT m_address_fk
	  FOREIGN KEY(m_address)
	  REFERENCES addresses(address)
	    ON DELETE SET NULL
);

CREATE SEQUENCE m_seq;

CREATE OR REPLACE TRIGGER m_inc
BEFORE INSERT ON musicians
FOR EACH ROW

BEGIN
  SELECT m_seq.NEXTVAL + 33322444   
  INTO :new.ssn
  FROM dual;
END;
/

CREATE TABLE albums
(
	album_id NUMBER not null,
	album_title VARCHAR2(127) NOT NULL,
	album_copy DATE NOT NULL,
	album_format VARCHAR2(32) NOT NULL,
	album_producer NUMBER NOT NULL,
	CONSTRAINT album_pk 
	  PRIMARY KEY (album_id),
	CONSTRAINT album_prod_fk
	  FOREIGN KEY (album_producer)
	  REFERENCES musicians(ssn)
);

CREATE SEQUENCE album_seq;

CREATE OR REPLACE TRIGGER album_inc
BEFORE INSERT ON albums
FOR EACH ROW

BEGIN
  SELECT album_seq.NEXTVAL
  INTO :new.album_id
  FROM dual;
END;
/


CREATE TABLE songs
(
	song_id number not null,
	title varchar2(127) not null,
	author varchar2(127) not null,
	album NUMBER,
	CONSTRAINT song_pk PRIMARY KEY (song_id),
	CONSTRAINT song_album_fk 
	  FOREIGN KEY (album)
	  REFERENCES albums(album_id)
	  ON DELETE SET NULL
);

CREATE SEQUENCE song_seq;

CREATE OR REPLACE TRIGGER song_inc
BEFORE INSERT ON songs
FOR EACH ROW

BEGIN
  SELECT song_seq.NEXTVAL
  INTO :new.song_id
  FROM dual;
END;
/
CREATE TABLE instruments
(
	instr_id NUMBER NOT NULL,
	instr_name VARCHAR2(32) NOT NULL,
	instr_key VARCHAR2(8) NOT NULL,
	CONSTRAINT instr_pk PRIMARY KEY (instr_id)
);

CREATE SEQUENCE instr_seq;

CREATE OR REPLACE TRIGGER instr_inc
BEFORE INSERT ON instruments
FOR EACH ROW

BEGIN
  SELECT instr_seq.NEXTVAL
  INTO :new.instr_id
  FROM dual;
END;
/

CREATE TABLE musician_plays_instrument
(
	m_ssn NUMBER NOT NULL,
	instr_id NUMBER NOT NULL,
	CONSTRAINT plays_pk
	  PRIMARY KEY (m_ssn, instr_id),
	CONSTRAINT play_m_fk 
	  FOREIGN KEY (m_ssn)
	  REFERENCES musicians(ssn)
	  ON DELETE CASCADE,
	CONSTRAINT plays_instr_fk
	  FOREIGN KEY (instr_id)
	  REFERENCES instruments(instr_id)
	  ON DELETE CASCADE
);

CREATE TABLE musician_performs_song
(
	m_ssn NUMBER NOT NULL,
	song_id NUMBER NOT NULL,
	CONSTRAINT performs_pk
	  PRIMARY KEY (m_ssn, song_id),
	CONSTRAINT performs_m_fk 
	  FOREIGN KEY (m_ssn)
	  REFERENCES musicians(ssn)
	  ON DELETE CASCADE,
	CONSTRAINT performs_song_fk
	  FOREIGN KEY (song_id)
	  REFERENCES songs(song_id)
	  ON DELETE CASCADE
);
