require 'rqrcode'
require 'will_paginate/array' 

class CompaniesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_admin!, only: [:new]
  before_action :authenticate_user!, only: [:show]
  # GET /companies
  # GET /companies.json

  # GET /companies/home
  def home
  end

  # GET /companies/users
  def users
    # if current_admin
    # @company = Company.find(current_admin.company_id)
    # else 
      # add a redirect later
    #  puts "admin not logged in, should not be able to see"
    # end
    # make sure to index to comapany_to_users
    @appliedUsers = Company.find_applicants_sql(["SELECT * FROM company_to_users WHERE company_id = ?", current_admin.company_id], params[:page])
    puts @appliedUsers
  end

  def info
    @company = Company.find(params[:id])
  end

  def index
    @companies = Company.search(params[:search]).paginate(page: params[:page], per_page: 10)
  end
  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
  end

  # PATCH /companies/1/apply
  def apply
    @company = Company.find(params[:id])
    puts current_user.id

    # Join Table Logic
    if @company.users.exists?(current_user.id)
      puts "You have already applied to this company"
    else
      @company.users << current_user
    end

    puts current_user.companies

  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    # Pass the id of the admin to this controller -> then save it in the corresponding admins
    if current_admin
      admin = Admin.find(current_admin.id)
    else
      # raise "User isn't logged in. This shouldn't happen"
      # make admin = Admin.find(current_user.id) and update the company that the admin created
    end

    @company = Company.new(company_params)    

    respond_to do |format|
      if @company.save
        # encode the url of the show company path as a QR code
        qr_code = qrcode = RQRCode::QRCode.new(request.base_url + '/companies/' + @company.id.to_s)
        qr_svg = qr_code.as_svg(
          offset: 0,
          #color: '000',
          shape_rendering: 'crispEdges',
          module_size: 4,
          standalone: true
        )
        @company.update_column(:qr_code, qr_svg)
        # admin.update_column(:company_id, @company.id) for load tests to work
        format.html { redirect_to admin_home_path, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      # @company = Company.find(params[:id])
      @company = Company.where(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :summary, :createdAt, :modifiedAt, :deletedAt)
    end
end
