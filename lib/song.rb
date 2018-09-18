class Song
@@all = []
attr_accessor :name
attr_reader :artist, :genre

def initialize(name, artist = nil, genre = nil)
  @name = name
  self.artist = artist if artist
  self.genre = genre if genre
end

def self.all
  @@all
end

def save
  @@all << self
end

def self.destroy_all
  @@all.clear
end

def self.create(name, artist = nil, genre = nil)
  new_song = self.new(name, artist = nil, genre = nil)
  new_song.save
  new_song
end

def artist=(artist)
  @artist = artist
  artist.add_song(self)
end

def genre=(genre)
  @genre = genre
  genre.songs << self unless genre.songs.include?(self)
end


def self.find_or_create_by_name(name)
  self.find_by_name(name) || self.create(name)
end

def self.find_by_name(name)
  self.all.detect{|s| s.name == name}
end

def self.new_from_filename(filename)
  file_array = filename.split(" - ")
  artist_name = file_array[0]
  song_name = file_array[1]
  genre_name = file_array[2].gsub(".mp3", "")

  artist = Artist.find_or_create_by_name(artist_name)
  genre = Genre.find_or_create_by_name(genre_name)
  self.new(song_name, artist, genre)
end

def self.create_from_filename(filename)
  new_file = self.new_from_filename(filename)
  new_file.save
end


###
end