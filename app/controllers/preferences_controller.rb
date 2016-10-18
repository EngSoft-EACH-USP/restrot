require 'bcrypt'
class PreferencesController < ApplicationController
include BCrypt

  
    def new
        @user = User.new
    end
    
    def password
        @user = User.find(session[:user_id])
        puts @user.name
        if (params[:user]).present?
            puts params[:user][:oldPassword]
            @password = BCrypt::Engine.hash_secret(params[:user][:oldPassword], @user.salt)
            if @password == @user.password
                if params[:user][:password] == params[:user][:passwordConfirmation]
                    @user.salt = nil
                    @user.password = params[:user][:password]
                   
                    if @user.save
                        flash[:notice] = "Senha alterada com sucesso!"
                        flash[:color]= "Válido"
                    else
                        flash[:notice] = "Erro!"
                        flash[:color]= "Inválido"
                    end
                else
                    flash[:notice] = "Senha e confirmação de senha não são iguais"
                    flash[:color]= "Invalido"
                end
            else
                flash[:notice] = "Senha inválida"
                flash[:color]= "Inválido"
            end
        end
       # render "edit" - falta o template
    end
end