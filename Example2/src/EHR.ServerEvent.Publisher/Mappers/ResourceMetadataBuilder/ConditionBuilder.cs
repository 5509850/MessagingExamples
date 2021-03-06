﻿using System;
using System.Collections.Generic;
using System.Text;
using Hl7.Fhir.Model;

namespace EHR.ServerEvent.Publisher.Mappers.ResourceMetadataBuilder
{
    public class ConditionBuilder:BaseResourceInformationBuilder<Condition>
    {
        protected override ResourceInfo GetRelatedPatientInformation(Condition resource)
        {
            return new ResourceInfo() { ResourceId = resource.Patient?.Reference };
        }
    }
}
