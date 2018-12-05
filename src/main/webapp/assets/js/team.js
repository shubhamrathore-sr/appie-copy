$(document).ready(function () {
    
    teamContainer = document.getElementsByClassName('teamsContainer')
    for(let i = 0; i< 10;i++) {
        teamCard = document.createElement('div');
        $(teamCard).addClass('teamCard')

        teamHead = document.createElement('div');
        $(teamHead).addClass('teamCardHead')

        teamDesc = document.createElement('div');
        $(teamDesc).addClass('teamDesc')

        teamMembers = document.createElement('div');
        $(teamMembers).addClass('teamMembers')


        p_tag = document.createElement('p');
        p_tag.appendChild(document.createTextNode("South")); 
        desc_p = document.createElement('p')
        desc_p.appendChild(document.createTextNode("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at porttitor sem.  Aliquam erat volutpat. Donec placerat nisl magna, et faucibus arcu condimentum sed."))
        membersCount = document.createElement('p')
        membersCount.appendChild(document.createTextNode("+20 members")); 

        image = document.createElement('img')
        $(image).attr("src","https://goo.gl/gVKjCQ");
        image1 = document.createElement('img')
        $(image1).attr("src","https://goo.gl/gVKjCQ");
        image2 = document.createElement('img')
        $(image2).attr("src","https://goo.gl/gVKjCQ");

        teamHead.append(p_tag);
        teamDesc.append(desc_p);
        teamMembers.append(image)
        teamMembers.append(image1)
        teamMembers.append(image2)

        teamMembers.append(membersCount)
        teamCard.append(teamHead)
        teamCard.append(teamDesc)
        teamCard.append(teamMembers)
        $(teamContainer).append(teamCard)
    }
})