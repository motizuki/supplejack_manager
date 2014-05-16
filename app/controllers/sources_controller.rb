# The majority of the Supplejack code is Crown copyright (C) 2014, New Zealand Government,
# and is licensed under the GNU General Public License, version 3. Some components are 
# third party components licensed under the GPL or MIT licenses or otherwise publicly available. 
# See https://github.com/DigitalNZ/supplejack_manager for details. 
# 
# Supplejack was created by DigitalNZ at the National Library of NZ and the Department of Internal Affairs. 
# http://digitalnz.org/supplejack

class SourcesController < ApplicationController

  respond_to :html, :json
  
  # GET /sources
  def index
    @sources = params[:source].present? ? Source.where(params[:source]) : Source.all
    respond_with @sources
  end

  # GET /sources/new
  def new
    @source = Source.new
    @source.partner = Partner.new
  end

  # GET /sources/1/edit
  def edit
    @source = Source.find(params[:id])
  end

  def show
    @source = Source.find(params[:id])
    respond_with @source
  end

  # POST /sources
  def create
    @source = Source.new(params[:source])

    if @source.save
      redirect_to sources_path, notice: 'Source was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /sources/1
  def update
    @source = Source.find(params[:id])

    if @source.update_attributes(params[:source])
      redirect_to sources_path, notice: 'Source was successfully updated.'
    else
      render action: "edit"
    end
  end

  def reindex
    @source = Source.find(params[:id])
    url = Figaro.env(params[:env])['API_HOST']
    RestClient.get("#{url}/sources/#{@source.id}/reindex?date=#{params[:date]}")
  end
end
