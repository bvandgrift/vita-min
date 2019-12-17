class VitaProvidersController < ApplicationController
  layout "client_facing"
  helper_method :provider_result_number

  def index
    @providers = []
    if params[:provider_search_form].present?
      @provider_search_form = ProviderSearchForm.new(provider_search_form_params)
      if @provider_search_form.valid?
        @providers = VitaProvider.sort_by_distance_from_zipcode(@provider_search_form.zip, @provider_search_form.page)
      end
    else
      @provider_search_form = ProviderSearchForm.new
    end
  end

  def show
    @provider = VitaProvider.find(params[:id])
    @zip = params[:zip]
    @distance = @provider.distance_from_zip(@zip) if @zip.present?
    @page = params[:page]
  end

  private

  def provider_result_number(index)
    page = @provider_search_form.page || 1
    prior_results_count = (page.to_i - 1) * 5
    prior_results_count + (index + 1)
  end

  def provider_search_form_params
    params.require(:provider_search_form).permit(:zip, :page)
  end
end