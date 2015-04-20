class FilmsGenericSearch
  attr_reader :q, :sort
  SORT = {
    name: { :'name.sorted' => :asc },
    year: { year: :desc },
    relevance: :_score,
    blank: { year: :desc, :'name.sorted' => :asc }
  }

  def initialize(q, sort = :relevance)
    @q = (q || '').strip
    @sort = sort

    if q.blank?
      @sort = :blank
    end
  end

  def index
    FilmsIndex
  end

  def search
    [query, sorting].compact.reduce(:merge)
  end

  def query
    case q
    when ''
      nil
    when /^gapoif:(.*+)$/i
      index.query(match_phrase: { gapoif: $1.strip }).min_score(5)
    else
      index.query(multi_match: { query: q, fields: ['*name'] })
    end
  end

  def sorting
    index.order(SORT[sort.to_sym])
  end

  def parse_q
    mode, rest = q.split(':')
    rest = rest.join(':')
    case mode
    when 'gapoif'
      [:gapoif, rest]
    else
      [:normal, q]
    end
  end
end
