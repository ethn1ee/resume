#import "cv.typ": *

#let cvdata = yaml("../resume.yaml")

#let uservars = (
	paper: "us-letter",
	margin: 1.25cm,
    headingfont: "Libertinus Serif",
    bodyfont: "Libertinus Serif",
    fontsize: 10pt,          // https://typst.app/docs/reference/layout/length
    linespacing: 5pt,        // length
    sectionspacing: 0pt,     // length
    showAddress: false,      // https://typst.app/docs/reference/foundations/bool
    showNumber: false,       // bool
    showTitle: false,        // bool
    headingsmallcaps: false, // bool
    sendnote: false,         // bool. set to false to have sideways endnote
)

#let cvinit(doc) = {
    doc = setrules(uservars, doc)
    doc = showrules(uservars, doc)

    doc
}

#show: doc => cvinit(doc)

#cvheading(cvdata, uservars)
#cveducation(cvdata)
#cvprojects(cvdata)
#cvwork(cvdata)
#cvskills(cvdata)
