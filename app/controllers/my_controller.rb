class MyController < ApplicationController
    def my_data
        respond_to do |format|
            format.js
          end
    end
end
