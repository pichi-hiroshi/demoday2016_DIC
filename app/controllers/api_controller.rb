def get_social_count
  count = eval("Api.get_#{params[:provider]}_count('#{params[:url]}')")
  render json: {count: count}
end