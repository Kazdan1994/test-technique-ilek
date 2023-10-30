module WineHelper
  def search_wines
    if params[:q].present?
      save_search
      search_response = Wine.__elasticsearch__.search(
        query: {
          multi_match: {
            query: params[:q],
            fields: %w[name properties marketplace]
          },
        },
        sort: [{ note: 'desc' }]
      )
      searches = search_response.records
      pagy(searches, items: 6)
    else
      pagy(sorted_wines, items: 6)
    end
  end

  def save_search
    return unless user_signed_in? || expert_signed_in?

    search = Search.find_or_create_by!(query: params[:q]) do |s|
      s.expert_id = current_expert&.id
      s.user_id = current_user&.id
    end

    search.touch
  end

  def redirect_to_last_page
    redirect_to action: 'search', q: params[:q]
  end

  def sorted_wines
    Wine.order(note: :desc)
  end
end
