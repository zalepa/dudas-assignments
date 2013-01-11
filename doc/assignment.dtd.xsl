<!DOCTYPE us-patent-assignments [



<!ELEMENT us-patent-assignments (action-key-code, transaction-date, patent-assignments)><!ATTLIST us-patent-assignments  dtd-version   CDATA  #IMPLIED date-produced CDATA  #IMPLIED>

	<!ELEMENT action-key-code (#PCDATA)>
	
	<!ELEMENT transaction-date (date)>
		<!ELEMENT date (#PCDATA)>
	
	<!ELEMENT patent-assignments (data-available-code | patent-assignment+)>


		<!ELEMENT data-available-code (#PCDATA)>


		<!ELEMENT patent-assignment (assignment-record, patent-assignors, patent-assignees, patent-properties)>
			

			<!-- 
				<assignment-record> MUST contain the nested elements 
			-->
			
			<!ELEMENT assignment-record (reel-no, frame-no, last-update-date, purge-indicator, recorded-date, page-count?, correspondent, conveyance-text)>
				<!ELEMENT reel-no (#PCDATA)>
				<!ELEMENT frame-no (#PCDATA)>
				<!ELEMENT last-update-date (date)>
				<!ELEMENT purge-indicator (#PCDATA)>
				<!ELEMENT recorded-date (date)>
				<!ELEMENT page-count (#PCDATA)>
				<!ELEMENT correspondent (name, address-1?, address-2?, address-3?, address-4?)>
					<!ELEMENT name (#PCDATA)><!ATTLIST name name-type (natural | legal)  #IMPLIED>
					<!ELEMENT address-1 (#PCDATA)>
					<!ELEMENT address-2 (#PCDATA)>
					<!ELEMENT address-3 (#PCDATA)>
					<!ELEMENT address-4 (#PCDATA)>


				<!ELEMENT conveyance-text (#PCDATA)>
			
			<!-- <patent-assignors> MUST include at least one <patent-assignor> but could have more than 1 -->
			<!ELEMENT patent-assignors (patent-assignor+)>
				<!-- name is required, dates are optional (but common) -->
				<!ELEMENT patent-assignor (name, execution-date?, date-acknowledged?)>
					<!ELEMENT name (#PCDATA)><!ATTLIST name name-type (natural | legal)  #IMPLIED>
					<!ELEMENT execution-date (date)>
					<!ELEMENT date-acknowledged (date)>


			<!ELEMENT patent-assignees (patent-assignee+)>
				<!ELEMENT patent-assignee (name, address-1?, address-2?, city?, state?, country-name?, postcode?)>
					<!ELEMENT name (#PCDATA)><!ATTLIST name name-type (natural | legal)  #IMPLIED>
					<!ELEMENT address-1 (#PCDATA)>
					<!ELEMENT address-2 (#PCDATA)>
					<!ELEMENT city (#PCDATA)>
					<!ELEMENT state (#PCDATA)>
					<!ELEMENT country-name (#PCDATA)>
					<!ELEMENT postcode (#PCDATA)>

			<!ELEMENT patent-properties (patent-property+)>
				<!ELEMENT patent-property (document-id*, invention-title?)>
					<!ELEMENT document-id (country, doc-number, kind?, name?, date?)>
						<!ELEMENT country (#PCDATA)>
						<!ELEMENT doc-number (#PCDATA)>
						<!ELEMENT kind (#PCDATA)>
						<!ELEMENT name (#PCDATA)><!ATTLIST name name-type (natural | legal)  #IMPLIED>
						<!ELEMENT date (#PCDATA)>

					<!ELEMENT invention-title (#PCDATA | b | i | u | sup | sub)*><!ATTLIST invention-title  id   ID     #IMPLIED lang CDATA  #REQUIRED>











<!--bold formatting for text-->
<!ELEMENT b (#PCDATA | i | u | smallcaps)*>
<!--italic formatting for text-->
<!ELEMENT i (#PCDATA | b | u | smallcaps)*>
<!--underscore: style - single is default-->
<!ELEMENT u (#PCDATA | b | i | smallcaps)*>
<!ATTLIST u  style  (single | double | dash | dots )  'single' >
<!--superscripted text-->
<!ELEMENT sup (#PCDATA | b | u | i)*>
<!--subscripted text-->
<!ELEMENT sub (#PCDATA | b | u | i)*>
<!--small capitals-->
<!ELEMENT smallcaps (#PCDATA | b | u | i)*>

]>