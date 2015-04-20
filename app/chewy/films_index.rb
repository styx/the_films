class FilmsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      title: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding', 'russian_snow', 'english_snow']
      },
      sorted: {
        tokenizer: 'keyword',
        filter: ['lowercase', 'asciifolding']
      },
      case_sensitive: {
        type: 'custom',
        tokenizer: 'keyword',
        filter: ['my_ngram']
      }
    },

    filter: {
      russian_snow: {
        type: 'snowball',
        language: 'Russian'
      },
      english_snow: {
        type: 'snowball',
        language: 'English'
      },
      my_ngram: {
        type: 'nGram'
      }
    }
  }

  define_type Film do
    field :id, type: 'integer'
    field :name, type: 'multi_field' do
      field :name, index: 'analyzed', analyzer: 'title'
      field :sorted, index: 'analyzed', analyzer: 'sorted'
    end

    field :second_name, index: 'analyzed', analyzer: 'title'
    field :gapoif, index: 'analyzed', analyzer: 'case_sensitive'
    field :year, type: 'integer'
  end
end
