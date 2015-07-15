# Homepage (Root path)
@login_error = false

get '/' do
  erb :'users/index'
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    artist:  params[:artist],
    url: params[:url]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

post '/votes' do
  @vote = Vote.new(
    song_id: params[:song_id],
    user_id: request.cookies['user_id']
  )
  if @vote.save
    redirect '/song'
  else
    "you already voted"
  end
end

get '/signup' do
  @user = User.new
  erb :'users/new'
end

post '/signup' do
  @user = User.new(
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    redirect '/login'
  else
    erb :'users/new'
  end
end


get '/login' do
  @user
  erb :'users/index'
end

post '/login' do
  #binding.pry
  if log_user = User.find_by(email: params[:email], password: params[:password])
     session[:current_user_id] = log_user.id
    @login_error = false
    redirect to('/songs')
  else
     @login_error = true
     erb :'users/index'
  end 
end
 
get '/logout' do
  session.clear
  redirect to('/login')
end