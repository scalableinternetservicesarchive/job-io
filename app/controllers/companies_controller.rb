require 'rqrcode'

class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:new]
  before_action :authenticate_user!, only: [:show]
  # GET /companies
  # GET /companies.json

  # GET /companies/home
  def home
  end

  def index
    @companies = Company.search(params[:search])
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
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
      puts "User isn't logged in. This shouldn't happen"
      # make admin = Admin.find(current_user.id) and update the company that the admin created
    end
    @company = Company.new(company_params)    

    puts request.base_url

    # @company = Company.new(company_params)

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
        admin.update_column(:company_id, @company.id)
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
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :createdAt, :modifiedAt, :deletedAt)
    end
end
