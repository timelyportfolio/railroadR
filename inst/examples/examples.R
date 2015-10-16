library(railroadR)

# examples from railroad-diagrams
#   https://github.com/tabatkins/railroad-diagrams/blob/master/example.html

railroad(
  NonTerminal('IDENT'),
  '('
)

railroad('@', NonTerminal('IDENT') )

railroad('#', NonTerminal('IDENT') )

railroad(
  Choice(0,
         Sequence(
           '"',
           ZeroOrMore(
             Choice(0,
                    NonTerminal('not " or \\'),
                    NonTerminal('escape'))),
           '"'),
         Sequence(
           "'",
           ZeroOrMore(
             Choice(0,
                    NonTerminal("not ' or \\"),
                    NonTerminal('escape'))),
           "'"))
)

railroad(
  Choice(0, 'u', 'U'),
	Choice(0, 'r', 'R'),
	Choice(0, 'l', 'L'),
	'(',
	Choice(1,
		Optional(NonTerminal('WS')),
		Sequence(
			Optional(NonTerminal('WS')),
			NonTerminal('STRING', '#string'),
			Optional(NonTerminal('WS'))),
		Sequence(
			Optional(NonTerminal('WS')),
			OneOrMore(
				Choice(0,
					NonTerminal('not " \' ( ) WS or NPC'),
          NonTerminal('escape'))),
          Optional(NonTerminal('WS'))
		    )
		),
  ')'
)

railroad(
  Choice(1, '+', Skip(), '-'),
  Choice(0,
         Sequence(
           OneOrMore(NonTerminal('digit')),
           '.',
           OneOrMore(NonTerminal('digit'))),
         OneOrMore(NonTerminal('digit')),
         Sequence(
           '.',
           OneOrMore(NonTerminal('digit')))),
  Choice(0,
         Skip(),
         Sequence(
           Choice(0, 'e', 'E'),
           Choice(1, '+', Skip(), '-'),
           OneOrMore(NonTerminal('digit'))))

)


railroad(
  Choice(1, '+', Skip(), '-'),
  Choice(0,
         Sequence(
           OneOrMore(NonTerminal('digit')),
           '.',
           OneOrMore(NonTerminal('digit'))),
         OneOrMore(NonTerminal('digit')),
         Sequence(
           '.',
           OneOrMore(NonTerminal('digit')))),
  Choice(0,
         Skip(),
         Sequence(
           Choice(0, 'e', 'E'),
           Choice(1, '+', Skip(), '-'),
           OneOrMore(NonTerminal('digit'))))
)

railroad(NonTerminal('NUMBER', '#number'), NonTerminal('IDENT'))

railroad(NonTerminal('NUMBER', '#number'), '%')

railroad(
  Choice(0,
         'U',
         'u'),
  '+',
  Choice(0,
         Sequence(OneOrMore(NonTerminal('hex digit'), Comment('1-6 times'))),
         Sequence(
           ZeroOrMore(NonTerminal('hex digit'), Comment('1-5 times')),
           OneOrMore('?', Comment('1 to (6 - digits) times'))),
         Sequence(
           OneOrMore(NonTerminal('hex digit'), Comment('1-6 times')),
           '-',
           OneOrMore(NonTerminal('hex digit'), Comment('1-6 times'))))
)

railroad(
  '/*',
  ZeroOrMore(
    NonTerminal("anything but * followed by /")),
  '*/'
)

railroad("<" + "!--")

railroad("-->")

railroad(
  Stack(
    Sequence(
      'SELECT',
      Optional('DISTINCT', 'skip'),
      Choice(0, 
             '*', 
             OneOrMore(
               Sequence(NonTerminal('expression'), Optional(Sequence('AS', NonTerminal('output_name')))), 
               ','
             )
      ),
      'FROM',
      OneOrMore(NonTerminal('from_item'), ','),
      Optional(Sequence('WHERE', NonTerminal('condition')))
    ),
    Sequence(
      Optional(Sequence('GROUP BY', NonTerminal('expression'))),
      Optional(Sequence('HAVING', NonTerminal('condition'))),
      Optional(Sequence(
        Choice(0, 'UNION', 'INTERSECT', 'EXCEPT'),
        Optional('ALL'),
        NonTerminal('select')
      ))
    ),
    Sequence(
      Optional(Sequence(
        'ORDER BY',
        OneOrMore(Sequence(NonTerminal('expression'), Choice(0, Skip(), 'ASC', 'DESC')), ','))
      ),
      Optional(Sequence(
        'LIMIT',
        Choice(0, NonTerminal('count'), 'ALL')
      )),
      Optional(Sequence('OFFSET', NonTerminal('start'), Optional('ROWS')))
    )
  )
)
