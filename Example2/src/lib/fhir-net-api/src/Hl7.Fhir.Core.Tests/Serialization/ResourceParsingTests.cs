﻿/* 
 * Copyright (c) 2014, Furore (info@furore.com) and contributors
 * See the file CONTRIBUTORS for details.
 * 
 * This file is licensed under the BSD 3-Clause license
 * available at https://raw.githubusercontent.com/ewoutkramer/fhir-net-api/master/LICENSE
 */

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Hl7.Fhir.Serialization;
using System.IO;
using Hl7.Fhir.Model;

namespace Hl7.Fhir.Tests.Serialization
{
    [TestClass]
#if PORTABLE45
	public class PortableResourceParsingTests
#else
	public class ResourceParsingTests
#endif
    {
        [TestMethod]
        //public void AcceptXsiStuffOnRoot()
        public void ConfigureFailOnUnknownMember()
        {
            var xml = "<Patient xmlns='http://hl7.org/fhir'><daytona></daytona></Patient>";

            try
            {
                FhirParser.ParseResourceFromXml(xml);
                Assert.Fail("Should have failed on unknown member");
            }
            catch (FormatException)
            {
            }

            SerializationConfig.AcceptUnknownMembers = true;
            FhirParser.ParseResourceFromXml(xml);
        }


        [TestMethod]
        public void AcceptXsiStuffOnRoot()
        {
            var xml = "<Patient xmlns='http://hl7.org/fhir' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' " +
                            "xsi:schemaLocation='http://hl7.org/fhir ../../schema/fhir-all.xsd'></Patient>";

            FhirParser.ParseResourceFromXml(xml);

            SerializationConfig.EnforceNoXsiAttributesOnRoot = true;

            try
            {
                FhirParser.ParseResourceFromXml(xml);
                Assert.Fail("Should have failed on xsi: elements in root");
            }
            catch (FormatException)
            {
            }
        }



        [TestMethod]
        public void AcceptNsStuffOnElements()
        {
            var xml = "<ValueSet xmlns=\"http://hl7.org/fhir\"><f:identifier xmlns:f=\"http://hl7.org/fhir\" value=\"...\"/></ValueSet>";

            FhirParser.ParseResourceFromXml(xml);

            SerializationConfig.EnforceNoXsiAttributesOnRoot = true;

            Assert.IsNotNull(FhirParser.ParseResourceFromXml(xml));
        }


        [TestMethod]
        public void RetainSpacesInAttribute()
        {
            var xml = "<Basic xmlns='http://hl7.org/fhir'><extension url='http://blabla.nl'><valueString value='Daar gaat ie dan" + "&#xA;" + "verdwijnt dit?' /></extension></Basic>";

            var basic = (DomainResource)FhirParser.ParseFromXml(xml);

            Assert.IsTrue(basic.GetStringExtension("http://blabla.nl").Contains("\n"));

            var outp = FhirSerializer.SerializeResourceToXml(basic);
            Assert.IsTrue(outp.Contains("&#xA;"));
        }

        [TestMethod]
        public void EdgecaseRoundtrip()
        {
            string json = File.ReadAllText(@"TestData\edgecases.json");

            var poco = FhirParser.ParseResourceFromJson(json);
            Assert.IsNotNull(poco);
            var xml = FhirSerializer.SerializeResourceToXml(poco);
            Assert.IsNotNull(xml);
            string tmpDir = Path.GetTempPath();
            File.WriteAllText(Path.Combine(tmpDir,@"edgecase.xml"), xml);

            poco = FhirParser.ParseResourceFromXml(xml);
            Assert.IsNotNull(poco);
            var json2 = FhirSerializer.SerializeResourceToJson(poco);
            Assert.IsNotNull(json2);
            File.WriteAllText(Path.Combine(tmpDir, @"edgecase.json"), json2);
           
            JsonAssert.AreSame(json, json2);
        }


        // TODO: Unfortunately, this is currently too much work to validate. See comments on the bottom of
        // https://github.com/ewoutkramer/fhir-net-api/issues/20
        [TestMethod, Ignore]
        public void CatchArrayWithNull()
        {
            var json = @"{
                'resourceType': 'Patient',
                'identifier': [null]
                }";

            try
            {
                var prof = FhirParser.ParseResourceFromJson(json);
                Assert.Fail("Should have failed parsing");
            }
            catch (FormatException)
            {
            }
            

        }
    }
}
