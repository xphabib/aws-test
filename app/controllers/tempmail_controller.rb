class TempmailController < ApplicationController
  def index
    if session['email'].nil?
      set_email
    end
    url = URI.parse('https://tempmailo.com/')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    email = params[:email].present? ? params[:email] : session['email']
    data = {mail: email}
    request = Net::HTTP::Post.new(url.path, {'Content-Type' => 'application/json'})

    requestverificationtoken = "CfDJ8LyadL38kbRNvnHvsedQcNHS1u_Ppem-3NmDBF2ntCph7SiYHxT8neNoZjkjEEQW-TuFJoZN_YdVC2T29y-vEzOQjhT_w0fawMbfhm_h3Sk7hOvR-szwcDB9wO3H8fcd2syfaEeDf91g4RoJNJD1qIs"
    cookie = ".AspNetCore.Antiforgery.dXyz_uFU2og=CfDJ8LyadL38kbRNvnHvsedQcNFoI643gsc-RLyUiL3XWmgRQeElrDkWM6lmUigq9KYOC2AFAs8CC964KJrymlRrywiruNGkQICeZS1yObxfS9wWNa1jAHIO57A6lNxZtMBNjRkxDx5iVVdorJV4EyQWFrg; __cf_bm=1033cbf370eb106282f6a01c58b7afbeda7dead1-1623901737-1800-AafU0Uhd2mShSwBXsUwZNL40zs77AjwVCDV2mrLCGYR8mBrA7ppHdH9KX47fzcLcGXGclW3xNZSvTMJJwlZ0A7WlrT4NnDjj/Adi0z7O/vs6GMIUJ206cphNWYDsZSgZ5Q==; _ym_uid=1623901740333815276; __gads=ID=f25861010cbb81fc-22ca7df392c900ba:T=1623901740:RT=1623901740:S=ALNI_MaY0znYcqNqmFjYKDTKtdydsBlg3Q; _ym_isad=2"
    request['requestverificationtoken'] = requestverificationtoken
    request['cookie'] = cookie

    request.body = data.to_json
    response = http.request(request)
    @obj = response.body
    @res = JSON.parse(response.body)
  end

  def change_mail
    set_email
    redirect_to tempmail_path
  end

  private
  def set_email
    uri = URI("https://tempmailo.com/changemail?_r=0.4306021000343454")
    req = Net::HTTP::Get.new(uri)
    requestverificationtoken = "CfDJ8LyadL38kbRNvnHvsedQcNHS1u_Ppem-3NmDBF2ntCph7SiYHxT8neNoZjkjEEQW-TuFJoZN_YdVC2T29y-vEzOQjhT_w0fawMbfhm_h3Sk7hOvR-szwcDB9wO3H8fcd2syfaEeDf91g4RoJNJD1qIs"
    cookie = ".AspNetCore.Antiforgery.dXyz_uFU2og=CfDJ8LyadL38kbRNvnHvsedQcNFoI643gsc-RLyUiL3XWmgRQeElrDkWM6lmUigq9KYOC2AFAs8CC964KJrymlRrywiruNGkQICeZS1yObxfS9wWNa1jAHIO57A6lNxZtMBNjRkxDx5iVVdorJV4EyQWFrg; __cf_bm=1033cbf370eb106282f6a01c58b7afbeda7dead1-1623901737-1800-AafU0Uhd2mShSwBXsUwZNL40zs77AjwVCDV2mrLCGYR8mBrA7ppHdH9KX47fzcLcGXGclW3xNZSvTMJJwlZ0A7WlrT4NnDjj/Adi0z7O/vs6GMIUJ206cphNWYDsZSgZ5Q==; _ym_uid=1623901740333815276; __gads=ID=f25861010cbb81fc-22ca7df392c900ba:T=1623901740:RT=1623901740:S=ALNI_MaY0znYcqNqmFjYKDTKtdydsBlg3Q; _ym_isad=2"
    req['requestverificationtoken'] = requestverificationtoken
    req['cookie'] = cookie
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) {|http|
      http.request(req)
    }
    session['email'] = res.body
  end
end
