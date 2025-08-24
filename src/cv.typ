#import "utils.typ"

// set rules
#let setrules(uservars, doc) = {
    set text(
        font: uservars.bodyfont,
        size: uservars.fontsize,
        hyphenate: false,
    )

    set list(
        spacing: uservars.linespacing
    )

    set par(
        leading: uservars.linespacing,
        justify: true,
    )

    doc
}

// show rules
#let showrules(uservars, doc) = {
    // Uppercase section headings
    show heading.where(
        level: 2,
    ): it => block(width: 100%)[
        #v(uservars.sectionspacing)
        #set align(left)
        #set text(font: uservars.headingfont, size: 1em, weight: "bold")
        #if (uservars.at("headingsmallcaps", default:false)) {
            smallcaps(it.body)
        } else {
            upper(it.body)
        }
        #v(-0.75em) #line(length: 100%, stroke: 1pt + black) // draw a line
    ]

    // Name title/heading
    show heading.where(
        level: 1,
    ): it => block(width: 100%)[
        #set text(font: uservars.headingfont, size: 1.5em, weight: "bold")
        #if (uservars.at("headingsmallcaps", default:false)) {
            smallcaps(it.body)
        } else {
            upper(it.body)
        }
        #v(2pt)
    ]

    show link: underline

    doc
}

// Set page layout
#let cvinit(doc) = {
    doc = setrules(doc)
    doc = showrules(doc)

    doc
}

// Job titles
#let jobtitletext(info, uservars) = {
    if ("titles" in info.personal and info.personal.titles != none) and uservars.showTitle {
        block(width: 100%)[
            *#info.personal.titles.join("  /  ")*
            #v(-4pt)
        ]
    } else {none}
}

// Address
#let addresstext(info, uservars) = {
    if ("location" in info.personal and info.personal.location != none) and uservars.showAddress {
        // Filter out empty address fields
        let address = info.personal.location.pairs().filter(it => it.at(1) != none and str(it.at(1)) != "")
        // Join non-empty address fields with commas
        let location = address.map(it => str(it.at(1))).join(", ")

        block(width: 100%)[
            #location
            #v(-4pt)
        ]
    } else {none}
}

#let contacttext(info, uservars) = block(width: 100%)[
    #let profiles = (
        if "email" in info.personal and info.personal.email != none { box(link("mailto:" + info.personal.email)) },
        if ("url" in info.personal) and (info.personal.url != none) {
            box(link(info.personal.url)[#info.personal.url.split("//").at(1)])
        }
    ).filter(it => it != none) // Filter out none elements from the profile array

    #if ("profiles" in info.personal) and (info.personal.profiles.len() > 0) {
        for profile in info.personal.profiles {
            profiles.push(
                box(link(profile.url)[#profile.url.split("//").at(1)])
            )
        }
    }

    #set text(font: uservars.bodyfont, weight: "medium", size: uservars.fontsize * 1)
    #pad(x: 0em)[
        #profiles.join([#sym.space #sym.dot #sym.space])
    ]
]

#let cvheading(info, uservars) = {
    align(center)[
        = #info.personal.name
        #jobtitletext(info, uservars)
        #addresstext(info, uservars)
        #contacttext(info, uservars)
    ]
}

#let cveducation(info, title: "Education", isbreakable: true) = {
    if ("education" in info) and (info.education != none) {block[
        == #title
        #for edu in info.education {
            let start = utils.strpdate(edu.startDate)
            let end = utils.strpdate(edu.endDate)

            let edu-items = ""
            if ("honors" in edu) and (edu.honors != none) {edu-items = edu-items + "- *Honors*: " + edu.honors.join(", ") + "\n"}
            if ("courses" in edu) and (edu.courses != none) {edu-items = edu-items + "- *Courses*: " + edu.courses.join(", ") + "\n"}
            if ("highlights" in edu) and (edu.highlights != none) {
                for hi in edu.highlights {
                    edu-items = edu-items + "- " + hi + "\n"
                }
                edu-items = edu-items.trim("\n")
            }

            // Create a block layout for each education entry
            block(width: 100%, breakable: isbreakable)[
                // Line 1: Institution and Location
                #if ("url" in edu) and (edu.url != none) [
                    *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \
                ] else [
                    *#edu.institution* #h(1fr) *#edu.location* \
                ]
                // Line 2: Degree and Date
                #if ("area" in edu) and (edu.area != none) [
                    #text(style: "italic")[#edu.studyType in #edu.area] #h(1fr)
                ] else [
                    #text(style: "italic")[#edu.studyType] #h(1fr)
                ]
                #utils.daterange(start, end) \
                #eval(edu-items, mode: "markup")
            ]
        }
    ]}
}

#let cvwork(info, title: "Work Experience", isbreakable: true) = {
    if ("work" in info) and (info.work != none) {block[
        == #title
        #for w in info.work {
            block(width: 100%, breakable: isbreakable)[
                *#w.position* #h(1fr) *#w.location* \
            ]

            block(width: 100%, breakable: isbreakable, above: 0.6em)[
                // Parse ISO date strings into datetime objects
                #let start = utils.strpdate(w.startDate)
                #let end = utils.strpdate(w.endDate)
                // Line 2: Position and Date Range
                #text(style: "italic")[#w.organization] #h(1fr)
                #utils.daterange(start, end) \
                // Highlights or Description
                #for hi in w.highlights [
                    - #eval(hi, mode: "markup")
                ]
            ]
        }
    ]}
}

#let cvprojects(info, title: "Projects", isbreakable: true) = {
    if ("projects" in info) and (info.projects != none) {block[
        == #title
        #for project in info.projects {
            // Parse ISO date strings into datetime objects
            let start = utils.strpdate(project.startDate)
            let end = utils.strpdate(project.endDate)
            // Create a block layout for each project entry
            block(width: 100%, breakable: isbreakable)[
                // Line 1: Project Name and Date
                *#project.name*  #h(1fr) #utils.daterange(start, end) \
                // Summary or Description
                #for hi in project.highlights [
                    - #eval(hi, mode: "markup")
                ]
            ]
        }
    ]}
}

#let cvskills(info, title: "Skills", isbreakable: true) = {
    block(breakable: isbreakable)[
        == #title
        #for group in info.skills [
            - *#group.category*: #group.skills.join(", ")
        ]
    ]
}
