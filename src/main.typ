#import "cv.typ": *

#let cvdata = yaml("../resume.yaml")

#let uservars = (
    headingfont: "Libertinus Serif",
    bodyfont: "Libertinus Serif",
    fontsize: 10pt,          // https://typst.app/docs/reference/layout/length
    linespacing: 6pt,        // length
    sectionspacing: 2pt,     // length
    showAddress: false,      // https://typst.app/docs/reference/foundations/bool
    showNumber: false,       // bool
    showTitle: false,        // bool
    headingsmallcaps: false, // bool
    sendnote: false,         // bool. set to false to have sideways endnote
)

#let customrules(doc) = {
    // add custom document style rules here
    set page(                // https://typst.app/docs/reference/layout/page
        paper: "us-letter",
        margin: 1.25cm,
    )

    // set list(indent: 1em)

    doc
}

#let cvinit(doc) = {
    doc = setrules(uservars, doc)
    doc = showrules(uservars, doc)
    doc = customrules(doc)

    doc
}

#show: doc => cvinit(doc)

#cvheading(cvdata, uservars)
#cveducation(cvdata)
#cvwork(cvdata)
#cvprojects(cvdata)
#cvskills(cvdata)
