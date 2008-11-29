class OtherController < ApplicationController
	before_filter :set_current_user, :except => [:pjs,:css5]
	def css5
	    render :layout => false
	end
	def pjs
	    render :layout => false
	end
	def prepare
		render :layout => false
	end
end
