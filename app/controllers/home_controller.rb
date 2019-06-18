class HomeController < ApplicationController


    def home
       @types = Campaign.occ_type_options
    end

    def test
      
    end

    # def admin
    #     # render :layout => false
    #     # byebug
    # end
end
