# Homepage (Root path)
get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

# get '/tracks/:id' do
#   @track = Track.find params[:id]
#   erb :'tracks/show'
# end

get '/tracks/:author' do
  @author = params[:author]
  @tracks = Track.where(:author => params[:author])
  erb :'tracks/author'
end


post '/tracks' do 
  @track = Track.new(
    created_at: params[:created_at],
    author: params[:author],
    artist_name: params[:artist],
    title: params[:title],
    url: params[:url]
  ) 
  if @track.save
    redirect '/tracks'
  else 
    erb :'tracks/new'
  end
end