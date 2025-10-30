#import "cv.typ": *

#let cvdata = yaml("../resume.yaml")

#let uservars = (
  paper: "us-letter",
  margin: 0.4in,
  headingfont: "Charter",
  bodyfont: "Charter",
  fontsize: 10pt,
  linespacing: 4pt,
  sectionspacing: 0pt,
  showAddress: false,
  showNumber: false,
  showTitle: false,
  headingsmallcaps: false,
  sendnote: false,
)

#let cvinit(doc) = {
  doc = setrules(uservars, doc)
  doc = showrules(uservars, doc)

  doc
}

#show: doc => cvinit(doc)

#cvheading(cvdata, uservars)
#cveducation(cvdata)
#cvwork(cvdata)
#cvprojects(cvdata)
#cvskills(cvdata)
