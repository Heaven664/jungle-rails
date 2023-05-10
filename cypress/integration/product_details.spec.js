describe('product specs', () => {
  it('visits the home page', () => {
    cy.visit('http://localhost:3000/');
  });

  it('opens a product page when clicking on a product element', () => {
    cy.get('.products article a').first().click()
    cy.contains(`The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.`)
  })
});
