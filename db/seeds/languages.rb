# frozen_string_literal: true

langs = {
  'Ruby': 'ruby',
  'Javascript': 'javascript',
  'Python': 'python',
  'Perl': 'perl',
  'HTML': 'html',
  'XML': 'xml',
  'CSS': 'css',
  'Java': 'java',
  'C': 'c',
  'C++': 'cpp',
  'Go': 'go',
  'Kotlin': 'kotlin',
  'Swift': 'swift',
  'Lisp': 'lisp',
  'Scala': 'scala'
}

languages = langs.map { |name, mode| Language.new(name: name, mode: mode) }
Language.import languages
