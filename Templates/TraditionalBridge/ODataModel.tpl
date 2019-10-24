<CODEGEN_FILENAME><StructureName>.dbl</CODEGEN_FILENAME>
<REQUIRES_CODEGEN_VERSION>5.4.2</REQUIRES_CODEGEN_VERSION>
;//****************************************************************************
;//
;// Title:       ODataModel.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to define structure based Data Object with CLR types
;//
;// Copyright (c) 2012, Synergex International, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;;*****************************************************************************
;;
;; Title:       <StructureName>.dbl
;;
;; Description: Data model representing data defined by the repository
;;              structure <STRUCTURE_NOALIAS><IF STRUCTURE_FILES> and from the data file <FILE_NAME></IF STRUCTURE_FILES>.
;;
;;*****************************************************************************
;; WARNING: GENERATED CODE!
;; This file was generated by CodeGen. Avoid editing the file if possible.
;; Any changes you make will be lost of the file is re-generated.
;;*****************************************************************************

import System
import System.Collections.Generic
import System.ComponentModel.DataAnnotations
import System.Text
import Harmony.Core
import Harmony.Core.Converters
<IF DEFINED_ENABLE_FIELD_SECURITY>
import Harmony.OData
</IF DEFINED_ENABLE_FIELD_SECURITY>

namespace <NAMESPACE>

    public partial class <StructureName> extends DataObjectBase

        ;;make the record available and a copy
        private mSynergyData, str<StructureName>
        private mOriginalSynergyData, str<StructureName>

        private static sMetadata, @<StructureName>Metadata

.region "Constructors"

        static method <StructureName>
        proc
            sMetadata = new <StructureName>Metadata()
            DataObjectMetadataBase.MetadataLookup.TryAdd(^typeof(<StructureName>), sMetadata)
        endmethod

        ;;; <summary>
        ;;;  Constructor, initialise the base fields
        ;;; </summary>
        public method <StructureName>
            parent()
        proc
            init mSynergyData, mOriginalSynergyData
        endmethod

        ;;; <summary>
        ;;;  Alternate Constructor, accepts the structured data
        ;;; </summary>
        public method <StructureName>
            required in inData, a
            required in inGrfa, a
            parent()
        proc
            mSynergyData = mOriginalSynergyData = inData
            mGlobalRFA = inGrfa
        endmethod

.endregion

.region "Attributes of this entity"

<IF STRUCTURE_RELATIVE>
        ;;; <summary>
        ;;; Record number
        ;;; </summary>
        public readwrite property RecordNumber, int

</IF STRUCTURE_RELATIVE>
<COUNTER_1_RESET>
<FIELD_LOOP>
  <IF USER>
  <ELSE>
    <IF CUSTOM_NOT_HARMONY_EXCLUDE>
        ;;; <summary>
        ;;; <FIELD_DESC>
        ;;; </summary>
;//
;// Field property attributes
;//
      <IF ONLY_PKSEGMENT>
        {Key}
      </IF ONLY_PKSEGMENT>
      <IF REQUIRED>
        {Required(ErrorMessage="<FIELD_DESC> is required. ")}
      </IF REQUIRED>
      <IF ALPHA>
        {StringLength(<FIELD_SIZE>, ErrorMessage="<FIELD_DESC> cannot exceed <FIELD_SIZE> characters. ")}
      </IF ALPHA>
      <IF DECIMAL>
        <IF CUSTOM_NOT_HARMONY_AS_STRING>
        {Range(<FIELD_MINVALUE>,<FIELD_MAXVALUE>, ErrorMessage="<FIELD_DESC> must be between <FIELD_MINVALUE> and <FIELD_MAXVALUE>. ")}
        </IF CUSTOM_NOT_HARMONY_AS_STRING>
      </IF DECIMAL>
      <IF INTEGER>
        {Range(<FIELD_MINVALUE>,<FIELD_MAXVALUE>, ErrorMessage="<FIELD_DESC> must be between <FIELD_MINVALUE> and <FIELD_MAXVALUE>. ")}
      </IF INTEGER>
;//
;// Field property
;//
      <IF DEFINED_ENABLE_FIELD_SECURITY>
        <IF CUSTOM_HARMONY_AUTHENTICATE>
        {AuthorizeField}
        </IF CUSTOM_HARMONY_AUTHENTICATE>
        <IF HARMONY_ROLES>
        {AuthorizeField("<HARMONY_ROLES>")}
        </IF HARMONY_ROLES>
      </IF DEFINED_ENABLE_FIELD_SECURITY>
      <COUNTER_1_INCREMENT>
      <IF CUSTOM_HARMONY_AS_STRING>
        public property <FieldSqlname>, String
      <ELSE>
        public property <FieldSqlname>, <HARMONYCORE_FIELD_DATATYPE>
      </IF CUSTOM_HARMONY_AS_STRING>
;//
;// Field property get method
;//
            method get
            proc
      <IF HARMONYCORE_CUSTOM_FIELD>
                mreturn <HARMONYCORE_CUSTOM_FIELD_TYPE>Converter.Convert(mSynergyData.<field_original_name_modified>)
      <ELSE>
        <IF ALPHA>
                mreturn (<FIELD_SNTYPE>)SynergyAlphaConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, ^null, ^null)
        </IF ALPHA>
        <IF DATE>
          <IF CUSTOM_HARMONY_AS_STRING>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XXXX-XX-XX")
          <ELSE>
                data formatString = "YYYYMMDD"
            <IF DATE_YYMMDD>
                formatString = "YYMMDD"
            </IF DATE_YYMMDD>
            <IF DATE_YYYYJJJ>
                formatString = "YYYYJJJ"
            </IF DATE_YYYYJJJ>
                mreturn SynergyDecimalDateConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, formatString, ^null)
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF DATE>
        <IF TIME_HHMM>
          <IF CUSTOM_HARMONY_AS_STRING>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XX:XX")
          <ELSE>
                mreturn Convert.ToDateTime(%string(mSynergyData.<field_original_name_modified>,"XX:XX"))
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF TIME_HHMM>
        <IF TIME_HHMMSS>
          <IF CUSTOM_HARMONY_AS_STRING>
                mreturn %string(mSynergyData.<field_original_name_modified>,"XX:XX:XX")
          <ELSE>
                mreturn Convert.ToDateTime(%string(mSynergyData.<field_original_name_modified>,"XX:XX:XX"))
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF TIME_HHMMSS>
        <IF DECIMAL>
          <IF CUSTOM_HARMONY_AS_STRING>
            <IF PRECISION>
                mreturn %string(SynergyImpliedDecimalConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, "DECIMALPLACES#<FIELD_PRECISION>", ^null),"<FIELD_FORMATSTRING>")
            <ELSE>
                mreturn %string(mSynergyData.<field_original_name_modified>,"<FIELD_FORMATSTRING>")
            </IF PRECISION>
          <ELSE>
            <IF PRECISION>
                mreturn (<FIELD_SNTYPE>)SynergyImpliedDecimalConverter.Convert(mSynergyData.<field_original_name_modified>, ^null, "DECIMALPLACES#<FIELD_PRECISION>", ^null)
            <ELSE>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
            </IF PRECISION>
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF DECIMAL>
        <IF INTEGER>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
        </IF INTEGER>
        <IF AUTO_SEQUENCE>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
        </IF AUTO_SEQUENCE>
        <IF AUTO_TIMESTAMP>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
        </IF AUTO_TIMESTAMP>
        <IF BOOLEAN>
                mreturn (<FIELD_SNTYPE>)mSynergyData.<field_original_name_modified>
        </IF BOOLEAN>
      </IF HARMONYCORE_CUSTOM_FIELD>
            endmethod
;//
;// Field property set method
;//
            method set
            proc
      <IF DEFINED_ENABLE_READ_ONLY_PROPERTIES>
        <IF READONLY>
                throw new ApplicationException("Property <FieldSqlname> is read only!")
        </IF READONLY>
      </IF DEFINED_ENABLE_READ_ONLY_PROPERTIES>
      <IF HARMONYCORE_CUSTOM_FIELD>
                mSynergyData.<field_original_name_modified> = <HARMONYCORE_CUSTOM_FIELD_TYPE>Converter.ConvertBack(value)
      <ELSE>
        <IF ALPHA>
                mSynergyData.<field_original_name_modified> = (<FIELD_TYPE>)SynergyAlphaConverter.ConvertBack(value<IF UPPERCASE>.ToUpper()</IF UPPERCASE>, ^null, ^null, ^null)
        </IF ALPHA>
        <IF DATE>
          <IF CUSTOM_HARMONY_AS_STRING>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XXXX-XX-XX")
          <ELSE>
                data formatString = "YYYYMMDD"
            <IF DATE_YYMMDD>
                formatString = "YYMMDD"
            </IF DATE_YYMMDD>
            <IF DATE_YYYYJJJ>
                formatString = "YYYYJJJ"
            </IF DATE_YYYYJJJ>
                mSynergyData.<field_original_name_modified> = (<FIELD_TYPE>)SynergyDecimalDateConverter.ConvertBack(value, ^null, formatString, ^null)
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF DATE>
        <IF TIME_HHMM>
          <IF CUSTOM_HARMONY_AS_STRING>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XX:XX")
          <ELSE>
                mSynergyData.<field_original_name_modified> = (value.Hour * 100) + value.Minute
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF TIME_HHMM>
        <IF TIME_HHMMSS>
          <IF CUSTOM_HARMONY_AS_STRING>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"XX:XX:XX")
          <ELSE>
                mSynergyData.<field_original_name_modified> = (value.Hour * 10000) + (value.Minute * 100) + value.Second
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF TIME_HHMMSS>
        <IF DECIMAL>
          <IF CUSTOM_HARMONY_AS_STRING>
            <IF PRECISION>
                mSynergyData.<field_original_name_modified> = SynergyImpliedDecimalConverter.ConvertBack(value,"<FIELD_FORMATSTRING>")
            <ELSE>
                mSynergyData.<field_original_name_modified> = SynergyDecimalConverter.ConvertBack(value,"<FIELD_FORMATSTRING>")
            </IF PRECISION>
          <ELSE>
                mSynergyData.<field_original_name_modified> = value
          </IF CUSTOM_HARMONY_AS_STRING>
        </IF DECIMAL>
        <IF INTEGER>
                mSynergyData.<field_original_name_modified> = value
        </IF INTEGER>
        <IF AUTO_SEQUENCE>
                mSynergyData.<field_original_name_modified> = value
        </IF AUTO_SEQUENCE>
        <IF AUTO_TIMESTAMP>
                mSynergyData.<field_original_name_modified> = value
        </IF AUTO_TIMESTAMP>
        <IF BOOLEAN>
                mSynergyData.<field_original_name_modified> = value
        </IF BOOLEAN>
      </IF HARMONYCORE_CUSTOM_FIELD>
            endmethod
;//
;// End of field property
;//
        endproperty

    </IF CUSTOM_NOT_HARMONY_EXCLUDE>
  </IF USER>
</FIELD_LOOP>
.endregion
;//
;//
;//

.region "Other attributes"

        ;;; <summary>
        ;;; Expose the complete synergy record
        ;;; </summary>
        public override property SynergyRecord, a
            method get
            proc
                mreturn mSynergyData
            endmethod
        endproperty

        ;;; <summary>
        ;;; Expose the complete original synergy record
        ;;; </summary>
        public override property OriginalSynergyRecord, a
            method get
            proc
                mreturn mOriginalSynergyData
            endmethod
        endproperty

        ;;; <summary>
        ;;; Metadata describing the public field properties
        ;;; </summary>
        public override property Metadata, @DataObjectMetadataBase
            method get
            proc
                mreturn sMetadata
            endmethod
        endproperty

.endregion

.region "Public methods"

        ;;; <summary>
        ;;;
        ;;; </summary>
        public override method InternalSynergyRecord, void
            targetMethod, @AlphaAction
        proc
            targetMethod(mSynergyData, mGlobalRFA)
        endmethod

        ;;; <summary>
        ;;; Allow the host to validate all fields. Each field will fire the validation method.
        ;;; </summary>
        public override method InitialValidateData, void
        proc
        endmethod

        ;;; <summary>
        ;;;
        ;;; </summary>
        public override method InternalGetValues, [#]@object
        proc
            ;;TODO: This should be returning boxed values for each of our fields
            mreturn new Object[<COUNTER_1_VALUE>]
        endmethod

.endregion
    endclass

endnamespace
