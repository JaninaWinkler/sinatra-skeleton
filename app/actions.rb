helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
end

get '/' do
  erb :index
end

get '/tracks' do
  @tracks = Track.all
  if params[:user_id]
    @tracks = @tracks.where(user_id: params[:user_id])
  end
  erb :'tracks/index'
end

get '/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks' do 
  @track = Track.new(
    created_at: params[:created_at],
    artist_name: params[:artist],
    title: params[:title],
    url: params[:url],
  ) 
  current_user.tracks << @track
  if @track.save
    redirect '/tracks'
  else 
    erb :'tracks/new'
  end
end

get '/login' do
  @message = params['message']
  erb :'/login'
end

post '/login' do
  @user = User.find_by(username: params[:username])
  if @user 
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      @message = "Login successful"
      redirect "/?message=#{@message}"
    else
      @message = "Invalid password"
      redirect "/login?message=#{@message}"
    end
  else
    @message = "Invalid username"
    redirect "/login?message=#{@message}"
  end
end

delete '/login' do
  session[:user_id] = nil
  redirect "/tracks?message=Logged out"
end

get '/signup' do
  erb :'/signup'
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      @message = "Account created"
      puts "#{@message}"
      redirect "/tracks?message=#{@message}"
    else
      erb :'/signup'
    end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

post '/upvote' do
  @upvote = Upvote.new(user_id: current_user.id, track_id: params[:track_id])
  if @upvote.save
      @message = "Upvote successful"
      redirect "/tracks?message=#{@message}"
    else 
      @message = "Can only upvote once"
      redirect "/tracks?message=#{@message}"
  end
end

post '/review' do
  @review = Review.new(user_id: current_user.id, track_id: params[:track_id], content: params[:content], rating: params[:rating])
  if @review.save
      @message = "Review post successful"
      redirect "/tracks/#{params[:track_id]}?message=#{@message}"
    else 
      @message = "Review post failed"
      redirect "/tracks/#{params[:track_id]}?message=#{@message}"
  end
end

get '/tracks/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end
