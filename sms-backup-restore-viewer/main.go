package main

import (
	"encoding/xml"
	"fmt"
	"io/ioutil"
	"os"
)

// our struct which contains the complete
// array of all Users in the file
type Smses struct {
	XMLName xml.Name `xml:"smses"`
	Smses   []Sms    `xml:"sms"`
}

// the user struct, this contains our
// Type attribute, our user's name and
// a social struct which will contain all
// our social links
type Sms struct {
	XMLName       xml.Name `xml:"sms"`
	Protocol      string   `xml:"protocol,attr"`
	Address       string   `xml:"address,attr"`
	Date          int      `xml:"date,attr"`
	Type          int      `xml:"type,attr"`
	Subject       string   `xml:"subject,attr"`
	Body          string   `xml:"body,attr"`
	Toa           string   `xml:"toa,attr"`
	ScToa         string   `xml:"sc_toa,attr"`
	ServiceCenter string   `xml:"servicecenter,attr"`
	Read          int      `xml:"read,attr"`
	Status        int      `xml:"status,attr"`
	Locked        string   `xml:"locked,attr"`
	ReadableDate  string   `xml:"readable_date,attr"`
	ContactName   string   `xml:"contact_name,attr"`
}

func main() {

	// Open our xmlFile
	filename := "sms.xml"
	xmlFile, err := os.Open(filename)
	// if we os.Open returns an error then handle it
	if err != nil {
		fmt.Println(err)
	}

	fmt.Printf("Successfully Opened %s\n", filename)
	// defer the closing of our xmlFile so that we can parse it later on
	defer xmlFile.Close()

	// read our opened xmlFile as a byte array.
	byteValue, _ := ioutil.ReadAll(xmlFile)

	// we initialize our Users array
	var smses Smses
	// we unmarshal our byteArray which contains our
	// xmlFiles content into 'users' which we defined above
	xml.Unmarshal(byteValue, &smses)

	// we iterate through every user within our users array and
	// print out the user Type, their name, and their facebook url
	// as just an example
	i := 0
	for _, sms := range smses.Smses {
		fmt.Println("Contact: " + sms.ContactName)
		fmt.Println("Phone: " + sms.Address)
		fmt.Println("Date: " + sms.ReadableDate)
		fmt.Println("Message: " + sms.Body)
		fmt.Println("------")
		i++
	}
	fmt.Printf("Parse %d entries\n", i)

}
