#include <stdio.h>
#include <GL/freeglut.h>
#include <GL/freeglut_ext.h>
#include <GL/freeglut_std.h>
#include <GL/glut.h>

float angle = 0;
int light0 = 1;
int light1 = 0;
int light2 = 0;
int light3 = 0;
int colorful = 1;

void drawCube(const GLfloat *first, const GLfloat *second, const GLfloat *third,
				const GLfloat *fourth, const GLfloat *fifth, const GLfloat *sixth)
{
	GLfloat spec[4] = { 1.0, 1.0, 1.0, 1.0 };
	// first cube
	// bottom
	glNormal3f(0.0, -1.0, 0.0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, first);
	glBegin(GL_POLYGON);
	{
		glVertex3f(-1.0, 0, 1.0);
		glVertex3f(0, 0, 1.0);
		glVertex3f(0, 0, 0);
		glVertex3f(-1.0, 0, 0);
	}
	glEnd();

	// back
	glNormal3f(0.0, 0.0, 1.0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, second);
	glBegin(GL_POLYGON);
	{
		glVertex3f(-1.0, 0, 0);
		glVertex3f(0, 0, 0);
		glVertex3f(0, 1.0, 0);
		glVertex3f(-1.0, 1.0, 0);
	}
	glEnd();

	// right side
	glNormal3f(1.0, 0.0, 0.0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, third);
	glBegin(GL_POLYGON);
	{
		glVertex3f(0, 1.0, 1.0);
		glVertex3f(0, 0, 1.0);
		glVertex3f(0, 0, 0);
		glVertex3f(0, 1.0, 0);
	}
	glEnd();

	// left side
	glNormal3f(-1.0, 0.0, 0.0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, fourth);
	glBegin(GL_POLYGON);
	{
		glVertex3f(-1.0, 1.0, 1.0);
		glVertex3f(-1.0, 0, 1.0);
		glVertex3f(-1.0, 0, 0);
		glVertex3f(-1.0, 1.0, 0);
	}
	glEnd();

	// front
	glNormal3f(0.0, 0.0, 1.0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, fifth);
	glBegin(GL_POLYGON);
	{
		glVertex3f(-1.0, 1.0, 1.0);
		glVertex3f(-1.0, 0, 1.0);
		glVertex3f(0, 0, 1.0);
		glVertex3f(0, 1.0, 1.0);
	}
	glEnd();

	// top
	glNormal3f(0.0, 1.0, 0.0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, sixth);
	glBegin(GL_POLYGON);
	{
		glVertex3f(-1.0, 1.0, 1.0);
		glVertex3f(0, 1.0, 1.0);
		glVertex3f(0, 1.0, 0);
		glVertex3f(-1.0, 1.0, 0);
	}
	glEnd();
}

void init()
{
	glClearColor(0.0, 0.0, 0.0, 1.0);
	glClearDepth(1.0);
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LESS);
	glHint(GL_POLYGON_SMOOTH_HINT, GL_NICEST);
	glEnable(GL_LIGHTING);
	glShadeModel(GL_FLAT);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
}

void display()
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	GLfloat light0_amb[4] = { 1.0, 1.0, 1.0, 1.0 };
	glLightfv(GL_LIGHT0, GL_AMBIENT, light0_amb);

	GLfloat light1_pos[4] = { 5.0, 5.0, 1.0, 1.0 };
	GLfloat light1_dif[4] = { 1.0, 1.0, 1.0, 1.0 };
	GLfloat light1_spec[4] = { 1.0, 1.0, 1.0, 1.0 };
	glLightfv(GL_LIGHT1, GL_POSITION, light1_pos);
	glLightfv(GL_LIGHT1, GL_DIFFUSE, light1_dif);
	glLightfv(GL_LIGHT1, GL_SPECULAR, light1_spec);

	GLfloat light2_pos[4] = { -5.0, -5.0, 1.0, 1.0 };
	GLfloat light2_dif[4] = { 1.0, 1.0, 1.0, 1.0 };
	GLfloat light2_spec[4] = { 1.0, 1.0, 1.0, 1.0 };
	glLightfv(GL_LIGHT2, GL_POSITION, light2_pos);
	glLightfv(GL_LIGHT2, GL_DIFFUSE, light2_dif);
	glLightfv(GL_LIGHT2, GL_SPECULAR, light2_spec);

	// a magenta light
	GLfloat light3_pos[4] = { 5.0, 0.0, 2.0, 1.0 };
	GLfloat light3_dif[4] = { 1.0, 0.0, 1.0, 1.0 };
	GLfloat light3_spec[4] = { 1.0, 1.0, 1.0, 1.0 };
	glLightfv(GL_LIGHT3, GL_POSITION, light3_pos);
	glLightfv(GL_LIGHT3, GL_DIFFUSE, light3_dif);
	glLightfv(GL_LIGHT3, GL_SPECULAR, light3_spec);

	if (light0)
		glEnable(GL_LIGHT0);
	else
		glDisable(GL_LIGHT0);

	if (light1)
		glEnable(GL_LIGHT1);
	else
		glDisable(GL_LIGHT1);

	if (light2)
		glEnable(GL_LIGHT2);
	else
		glDisable(GL_LIGHT2);

	if (light3)
		glEnable(GL_LIGHT3);
	else
		glDisable(GL_LIGHT3);

	gluLookAt(-0.5, 2.5, 4, -0.5, 1.5, 0, 0, 1, 0);       

	GLfloat const green[4] = { 0.0, 1.0, 0.0, 1.0 };
	GLfloat const blue[4] = { 0.0, 0.0, 1.0, 1.0 };
	GLfloat const red[4] = { 1.0, 0.0, 0.0, 1.0 };
	GLfloat const orange[4] = { 1.0, 0.5, 0.0, 1.0 };
	GLfloat const yellow[4] = { 1.0, 1.0, 0.0, 1.0 };
	GLfloat const cyan[4] = { 0.0, 1.0, 1.0, 1.0 };

	GLfloat const gray1[4] = { 0.5098, 0.549, 0.6078, 1.0 }; // a bluish gray
	GLfloat const gray2[4] = { 0.4941, 0.5412, 0.549, 1.0 }; // a cyanish gray
	GLfloat const gray3[4] = { 0.3882, 0.3686, 0.349, 1.0 }; // an orange-y gray
	GLfloat const gray4[4] = { 0.3922, 0.4392, 0.3843, 1.0 }; // a greenish gray
	GLfloat const gray5[4] = { 0.3176, 0.2745, 0.2667, 1.0 }; // a reddish gray
	GLfloat const gray6[4] = { 0.3765, 0.3725, 0.3255, 1.0 }; // a yellowish gray

	glPushMatrix();
	glTranslatef(-0.5, 0, 0.5);
	glRotatef(angle, 0, 1, 0);
	glTranslatef(0.5, 0, -0.5);

	if (colorful)
	{
		// first cube
		drawCube(green, blue, red, orange, yellow, cyan);

		glPushMatrix();

		// second cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(yellow, green, cyan, red, orange, blue);

		// third cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(cyan, red, yellow, green, blue, orange);

		// fourth cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(blue, cyan, orange, yellow, green, red);

		// fifth cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(orange, yellow, blue, cyan, red, green);

		// sixth cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(red, orange, green, blue, cyan, yellow);
		glPopMatrix();
	}

	else // gray
	{
		// first cube
		drawCube(gray4, gray1, gray5, gray3, gray6, gray2);

		glPushMatrix();

		// second cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(gray6, gray4, gray2, gray5, gray3, gray1);

		// third cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(gray2, gray5, gray6, gray4, gray1, gray3);

		// fourth cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(gray1, gray2, gray3, gray6, gray4, gray5);

		// fifth cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(gray3, gray6, gray1, gray2, gray5, gray4);

		// sixth cube
		glScalef(0.666666, 0.666666, 0.666666);
		glTranslatef(-0.25, 1.5, 0.25);
		drawCube(gray5, gray3, gray4, gray1, gray2, gray6);
		glPopMatrix();
	}

	glPopMatrix();
	glutSwapBuffers();
}

void idle()
{
	glutPostRedisplay();
}

void keyboard(unsigned char k, int x, int y)
{
	if (k == 'q' || k == 'Q')
		exit(0);
	else if (k == 'a' || k == 'A')
		angle -= 15;
	else if (k == 'd' || k == 'D')
		angle += 15;
	else if (k == '1')
		light0 = !light0;
	else if (k == '2')
		light1 = !light1;
	else if (k == '3')
		light2 = !light2;
	else if (k == '4')
		light3 = !light3;
	else if (k == 'c' || k == 'C')
		colorful = !colorful;
}


void reshape(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60, (GLfloat)w / (GLfloat)h, 1.0, 100.0); // used from http://www.swiftless.com/tutorials/opengl/reshape.html
	glMatrixMode(GL_MODELVIEW);
}

int main(int argc, char* argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(800, 400);
	glutCreateWindow("Lighted Stacked Drive Ya Crazy");
	init();
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutIdleFunc(idle);
	glutKeyboardFunc(keyboard);
	glutMainLoop();

	return 0;
}

