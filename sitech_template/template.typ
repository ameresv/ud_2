#let sitech-short(
  author : "Ali Meres",
  date : datetime.today(),
  doc
) = {
  set page(
    "a4",
    margin: (top: 3.2cm),
    header-ascent: 0.71cm,
    header: [
      #place(left, image("logo.png", height: 1.28cm), dy: 1.25cm)
      #place(right + bottom)[
        #text(weight:"bold")[#author] \
        #if type(date) == datetime [
          #date.display("[day]/[month]/[year]")
        ] else [
          #date
        ]
      ]
    ]
  )

  show heading.where(
    level: 1
  ): it => block(width: 100%)[
    #set block(spacing:0.5em)  
    #set align(center)
    #set text(20pt, weight: "bold")
    #smallcaps(it.body)
  ]
  
  show heading.where(
    level: 2
  ): it => block(width: 100%)[
    #set block(spacing:0.5em)  
    #set text(16pt, weight: "bold")
    #smallcaps(it.body)
  ]

doc
}
