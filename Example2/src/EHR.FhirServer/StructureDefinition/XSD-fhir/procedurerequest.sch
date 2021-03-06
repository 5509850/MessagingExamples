<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the resource ProcedureRequest
    It is provided for documentation purposes. When actually validating,
    always use fhir-invariants.sch (because of the way containment works)
    Alternatively you can use this file to build a smaller version of
    fhir-invariants.sch (the contents are identical; only include those 
    resources relevant to your implementation).
  -->
    <sch:pattern>
      <sch:title>Global</sch:title>
      <sch:rule context="f:*">
        <sch:assert test="@value|f:*|h:div">global-1: All FHIR elements must have a @value or children</sch:assert>
      </sch:rule>
    </sch:pattern>
  <sch:pattern>
    <sch:title>ProcedureRequest</sch:title>
    <sch:rule context="f:ProcedureRequest/f:meta/f:security">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:meta/f:tag">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest">
      <sch:assert test="not(exists(f:contained/f:meta/f:versionId)) and not(exists(f:contained/f:meta/f:lastUpdated))">dom-4: If a resource is contained in another resource, it SHALL not have a meta.versionId or a meta.lastUpdated</sch:assert>
      <sch:assert test="not(exists(for $id in f:contained/*/@id return $id[not(ancestor::f:contained/parent::*/descendant::f:reference/@value=concat('#', $id))]))">dom-3: If the resource is contained in another resource, it SHALL be referred to from elsewhere in the resource</sch:assert>
      <sch:assert test="not(parent::f:contained and f:contained)">dom-2: If the resource is contained in another resource, it SHALL not contain nested Resources</sch:assert>
      <sch:assert test="not(parent::f:contained and f:text)">dom-1: If the resource is contained in another resource, it SHALL not contain any narrative</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:text/f:div">
      <sch:assert test="descendant::text()[normalize-space(.)!=''] or descendant::h:img[@src]">txt-2: The narrative SHALL have some non-whitespace content</sch:assert>
      <sch:assert test="not(descendant-or-self::*[not(local-name(.)=('a', 'abbr', 'acronym', 'b', 'big', 'blockquote', 'br', 'caption', 'cite', 'code', 'colgroup', 'dd', 'dfn', 'div', 'dl', 'dt', 'em', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'hr', 'i', 'img', 'li', 'ol', 'p', 'pre', 'q', 'samp', 'small', 'span', 'strong', 'table', 'tbody', 'td', 'tfoot', 'th', 'thead', 'tr', 'tt', 'ul', 'var'))])">txt-1: The narrative SHALL contain only the basic html formatting elements described in chapters 7-11 (except section 4 of chapter 9) and 15 of the HTML 4.0 standard, &lt;a&gt; elements (either name or href), images and internally contained style attributes</sch:assert>
      <sch:assert test="not(descendant-or-self::*/@*[not(name(.)=('abbr', 'accesskey', 'align', 'alt', 'axis', 'bgcolor', 'border', 'cellhalign', 'cellpadding', 'cellspacing', 'cellvalign', 'char', 'charoff', 'charset', 'cite', 'class', 'colspan', 'compact', 'coords', 'dir', 'frame', 'headers', 'height', 'href', 'hreflang', 'hspace', 'id', 'lang', 'longdesc', 'name', 'nowrap', 'rel', 'rev', 'rowspan', 'rules', 'scope', 'shape', 'span', 'src', 'start', 'style', 'summary', 'tabindex', 'title', 'type', 'valign', 'value', 'vspace', 'width'))])">txt-3: The narrative SHALL contain only the basic html formatting attributes described in chapters 7-11 (except section 4 of chapter 9) and 15 of the HTML 4.0 standard, &lt;a&gt; elements (either name or href), images and internally contained style attributes</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:contained/f:meta/f:security">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:contained/f:meta/f:tag">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:contained/f:meta/f:security">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:contained/f:meta/f:tag">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:identifier/f:type">
      <sch:assert test="count(f:coding[f:primary/@value='true'])&lt;=1">ccc-2: Только один кодинг из набора может быть выбран непосредственно пользователем</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:identifier/f:type/f:coding">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:identifier/f:period">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">per-1: Если указана, начальная дата ДОЛЖНА быть меньше, чем дата окончания</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:identifier/f:assigner">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:subject">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:type">
      <sch:assert test="count(f:coding[f:primary/@value='true'])&lt;=1">ccc-2: Только один кодинг из набора может быть выбран непосредственно пользователем</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:type/f:coding">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:bodySite/f:siteCodeableConcept">
      <sch:assert test="count(f:coding[f:primary/@value='true'])&lt;=1">ccc-2: Только один кодинг из набора может быть выбран непосредственно пользователем</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:bodySite/f:siteCodeableConcept/f:coding">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:bodySite/f:siteReference">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:indication">
      <sch:assert test="count(f:coding[f:primary/@value='true'])&lt;=1">ccc-2: Только один кодинг из набора может быть выбран непосредственно пользователем</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:indication/f:coding">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingPeriod">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">per-1: Если указана, начальная дата ДОЛЖНА быть меньше, чем дата окончания</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingTiming/f:repeat">
      <sch:assert test="not(exists(f:frequency)) or not(exists(f:when))">tim-3: Можно указать либо frequency, либо when, но не оба</sch:assert>
      <sch:assert test="not(exists(f:duration)) or exists(f:durationUnits)">tim-1: если duration указан, необходимо указать и единицы измерения продолжительности</sch:assert>
      <sch:assert test="not(exists(f:period)) or exists(f:periodUnits)">tim-2: если period указан, необходимо указать и единицы измерения продолжительности</sch:assert>
      <sch:assert test="not(exists(f:periodMax)) or exists(period)">tim-6: Если указан periodMax, то должен быть указан и period</sch:assert>
      <sch:assert test="not(exists(f:durationMax)) or exists(duration)">tim-7: Если указан durationMax, то должен быть указан и duration</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingTiming/f:repeat/f:bounds">
      <sch:assert test="not(exists(f:start)) or not(exists(f:end)) or (f:start/@value &lt;= f:end/@value)">per-1: Если указана, начальная дата ДОЛЖНА быть меньше, чем дата окончания</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingTiming/f:repeat/f:duration">
      <sch:assert test="@value &gt;= 0 or not(@value)">tim-4: duration ДОЛЖЕН иметь неотрицательное значение</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingTiming/f:repeat/f:period">
      <sch:assert test="@value &gt;= 0 or not(@value)">tim-5: period ДОЛЖЕН иметь неотрицательное значение</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingTiming/f:code">
      <sch:assert test="count(f:coding[f:primary/@value='true'])&lt;=1">ccc-2: Только один кодинг из набора может быть выбран непосредственно пользователем</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:timingTiming/f:code/f:coding">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:encounter">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:performer">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:asNeededCodeableConcept">
      <sch:assert test="count(f:coding[f:primary/@value='true'])&lt;=1">ccc-2: Только один кодинг из набора может быть выбран непосредственно пользователем</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:asNeededCodeableConcept/f:coding">
      <sch:assert test="not (exists(f:valueSet) and exists(f:code)) or exists(f:system)">cod-1: Если указан valueSet, то также необходимо указать и URI системы</sch:assert>
    </sch:rule>
    <sch:rule context="f:ProcedureRequest/f:orderer">
      <sch:assert test="not(starts-with(f:reference/@value, '#')) or exists(ancestor::f:entry/f:resource/f:*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')]|/*/f:contained/f:*[f:id/@value=substring-after(current()/f:reference/@value, '#')])">ref-1: SHALL have a local reference if the resource is provided inline</sch:assert>
    </sch:rule>
    </sch:pattern>
</sch:schema>
