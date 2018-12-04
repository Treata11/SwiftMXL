//
//  Opus.swift
//  MusicXML
//
//  Created by James Bean on 12/3/18.
//

// MARK: TODO
//
//<!--
//    MusicXML Opus DTD
//
//    Version 3.1
//
//    Copyright © 2004-2017 the Contributors to the MusicXML
//    Specification, published by the W3C Music Notation Community
//    Group under the W3C Community Final Specification Agreement
//    (FSA):
//
//       https://www.w3.org/community/about/agreements/final/
//
//    A human-readable summary is available:
//
//       https://www.w3.org/community/about/agreements/fsa-deed/
//-->
//
//<!--
//    An opus collects MusicXML scores together into a larger
//    entity. The individual scores could be movements in a
//    symphony, scenes or acts in an opera, or songs in an
//    album. The opus definition allows arbitrary nesting
//    either via an opus (included in the document) or an
//    opus-link (linked like scores). Future versions of the
//    MusicXML format may expand this DTD to include reference
//    data and other metadata related to musical scores.
//
//    Suggested use:
//
//    <!DOCTYPE opus PUBLIC
//        "-//Recordare//DTD MusicXML 3.1 Opus//EN"
//        "http://www.musicxml.org/dtds/opus.dtd">
//-->
//
//<!-- Component DTD modules -->
//
//<!--
//    The common DTD module contains the entities and elements
//    that are shared among multiple DTD modules.
//-->
//<!ENTITY % common PUBLIC
//    "-//Recordare//ELEMENTS MusicXML 3.1 Common//EN"
//    "common.mod">
//%common;
//
//<!--
//    The link DTD module contains XLink attributes.
//-->
//<!ENTITY % link PUBLIC
//    "-//Recordare//ELEMENTS MusicXML 3.1 Link//EN"
//    "link.mod">
//%link;
//
//<!-- Elements -->
//
//<!--
//    Opus is the document element. The document-attributes
//    entity includes the version attribute and is defined in
//    the common.mod file.
//-->
//<!ELEMENT opus (title?, (opus | opus-link | score)*)>
//<!ATTLIST opus
//    %document-attributes;
//>
//
//<!--
//    The score elements provide the links to the individual
//    movements. The new-page attribute, added in Version
//    2.0, is used to indicate if the first page of the score is
//    different than the last page of the previous score. If
//    new-page is "yes", then a different page is used; if
//    "no", then the same page is used. The default value is
//    implementation-dependent.
//-->
//<!ELEMENT score EMPTY>
//<!ATTLIST score
//    %link-attributes;
//    new-page %yes-no; #IMPLIED
//>
//
//<!--
//    An opus-link provides a link to another opus document,
//    allowing for multiple levels of opus collections via
//    linking as well as nesting.
//-->
//<!ELEMENT opus-link EMPTY>
//<!ATTLIST opus-link %link-attributes;>
//
//<!--
//    Future versions may include metadata elements. In
//    this version, we just include the title of the opus.
//-->
//<!ELEMENT title (#PCDATA)>
