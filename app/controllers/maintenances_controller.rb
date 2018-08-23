class MaintenancesController < ApplicationController


    get '/maintenances/new' do
        if logged_in? 
            @user = current_user
            erb :'/maintenances/create_maintenance'
        else
            redirect :'/users/login'
        end
    end

    post '/maintenances/new' do
        # raise params.inspect
        # binding.pry
        @maintenance = Maintenance.create(params)
        @equipment = Equipment.find_by_id(params[:equipment_id])
        @user = current_user
        @user.maintenances << @maintenance
        @equipment.maintenances << @maintenance

        redirect :"/maintenances/#{@maintenance.id}"
    end

    get '/maintenances/:id' do
        @maintenance = Maintenance.find_by_id(params[:id])
        @user = @maintenance.user
        @equipment = @maintenance.equipment

        erb :'/maintenances/show_maintenance'
    end




end
