#include <stdio.h>
#include <GL/freeglut.h>
#include <GL/freeglut_ext.h>
#include <GL/freeglut_std.h>
#include <GL/glut.h>
#include <math.h>

// P to pause
// Q to quit
// B to blast (hit attacker)

const float PI = 3.141592653589793238463f;

float x2 = 0;
float x3 = 745;
float speed = 0.1;
bool attacker = true;
bool paused = false;
bool energy = false;
bool gameover = false;

void drawAttacker()
{
	float sum = x2 + 10;
	// code for circle used from programanddesign.com/cpp/draw-an-unfilled-circle
	glColor3f(0.0, 0.0, 0.0);
	double inc = PI / 12;
	double max = 2 * PI;
	glBegin(GL_LINE_LOOP);
	for (double d = 0; d < max; d += inc)
		glVertex2f(cos(d) * 10 + (x2 + 10), sin(d) * 10 + 95);
	glEnd();

	glBegin(GL_LINES);
	{
		// body
		glVertex2f(sum, 85);
		glVertex2f(sum, 68);

		// right arm
		glVertex2f(sum, 75);
		glVertex2f(x2 + 15, 82);

		// left arm
		glVertex2f(sum, 75);
		glVertex2f(x2 + 5, 82);

		// right leg
		glVertex2f(sum, 68);
		glVertex2f(x2 + 15, 60);

		// left leg
		glVertex2f(sum, 68);
		glVertex2f(x2 + 5, 60);
	}
	glEnd();
	attacker = true;
}

void removeAttacker()
{
	// just a rectangle for now
	// x2, 110		x2 + 20, 110
	// x2, 60		x2 + 20, 60

	glColor3f(0.717647, 0.694118, 0.682353);
	glBegin(GL_POLYGON);
	{
		glVertex2f(x2, 110);
		glVertex2f(x2 + 20, 110);
		glVertex2f(x2 + 20, 60);
		glVertex2f(x2, 60);
	}
	glEnd();
	attacker = false;
}

void drawEnergy()
{
	// this will be remaining a rectangle
	glColor3f(1.0, 1.0, 1.0);
	glBegin(GL_POLYGON);
	{
		glVertex2f(x3, 90);
		glVertex2f(x3 - 20, 90);
		glVertex2f(x3 - 20, 80);
		glVertex2f(x3, 80);
	}
	glEnd();
}

void removeEnergy()
{
	// this will be remaining a rectangle
	glColor3f(0.717647, 0.694118, 0.682353);
	glBegin(GL_POLYGON);
	{
		glVertex2f(x3, 90);
		glVertex2f(x3 - 20, 90);
		glVertex2f(x3 - 20, 80);
		glVertex2f(x3, 80);
	}
	glEnd();
	energy = false;
}

void gameOver()
{
	glClearColor(0.266667, 0.270588, 0.278431, 0.0);
	glClear(GL_COLOR_BUFFER_BIT);

	glutSetWindowTitle("Game Over");
}

void init()
{
	glClearColor(0.854902, 0.780392, 0.898039, 0.0);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0.0, 1100, 0.0, 600); // left, right, bottom, top
}

void display()
{
	glClear(GL_COLOR_BUFFER_BIT);
	glLineWidth(1);

	// ground
	glColor3f(0.717647, 0.694118, 0.682353);
	glBegin(GL_POLYGON);
	{
		glVertex2f(0, 160);
		glVertex2f(3000, 160);
		glVertex2f(3000, 0);
		glVertex2f(0, 0);
	}
	glEnd();

	// background

	glColor3f(0.490196, 0.388235, 0.54902);
	glBegin(GL_POLYGON);
	{
		glVertex2f(225, 500);
		glVertex2f(350, 500);
		glVertex2f(350, 160);
		glVertex2f(225, 160);
	}
	glEnd();

	glColor3f(0.74902, 0.545098, 0.721569);
	glBegin(GL_POLYGON);
	{
		glVertex2f(100, 360);
		glVertex2f(250, 360);
		glVertex2f(250, 160);
		glVertex2f(100, 160);
	}
	glEnd();

	glColor3f(0.380392, 0.392157, 0.509804);
	glBegin(GL_POLYGON);
	{
		glVertex2f(450, 400);
		glVertex2f(550, 400);
		glVertex2f(550, 160);
		glVertex2f(450, 160);
	}
	glEnd();

	glColor3f(0.858824, 0.686275, 0.858824);
	glBegin(GL_POLYGON);
	{
		glVertex2f(540, 300);
		glVertex2f(625, 300);
		glVertex2f(625, 160);
		glVertex2f(540, 160);
	}
	glEnd();

	glColor3f(0.298039, 0.239216, 0.298039);
	glBegin(GL_POLYGON);
	{
		glVertex2f(975, 475);
		glVertex2f(1075, 475);
		glVertex2f(1075, 160);
		glVertex2f(975, 160);
	}
	glEnd();

	// fence (to give some perspective - better than doing windows)
	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(0, 175);
		glVertex2f(3000, 175);
		for (int i = 0; i < 3000; i += 10)
		{
			glVertex2f(i, 175);
			glVertex2f(i, 160);
		}
	}
	glEnd();

	// side of building
	glColor3f(0.090196, 0.184314, 0.337255);
	glBegin(GL_POLYGON);
	{
		glVertex2f(850, 370);
		glVertex2f(1000, 370);
		glVertex2f(1000, 70);
		glVertex2f(850, 70);
	}
	glEnd();

	// front of building
	glColor3f(0.058824, 0.129412, 0.239216);
	glBegin(GL_POLYGON);
	{
		glVertex2f(800, 380);
		glVertex2f(850, 370);
		glVertex2f(850, 70);
		glVertex2f(800, 80);
	}
	glEnd();

	// top of building
	glColor3f(0.082353, 0.196078, 0.376471);
	glBegin(GL_POLYGON);
	{
		glVertex2f(800, 380);
		glVertex2f(955, 380);
		glVertex2f(1000, 370);
		glVertex2f(850, 370);
	}
	glEnd();

	// door
	glColor3f(0.658824, 0.8, 0.843137);
	glBegin(GL_POLYGON);
	{
		glVertex2f(810, 135);
		glVertex2f(835, 127.5);
		glVertex2f(835, 73);
		glVertex2f(810, 78);
	}
	glEnd();

	glColor3f(0.42, 0.43, 0.44);
	glBegin(GL_LINES);
	{
		glVertex2f(822.5, 132.5);
		glVertex2f(822.5, 73);
	}
	glEnd();

	// first row of side windows
	glColor3f(0.73, 0.87, 0.91);
	glBegin(GL_POLYGON);
	{
		glVertex2f(875, 345);
		glVertex2f(920, 345);
		glVertex2f(920, 305);
		glVertex2f(875, 305);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(930, 345);
		glVertex2f(975, 345);
		glVertex2f(975, 305);
		glVertex2f(930, 305);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(897.5, 345);
		glVertex2f(897.5, 305);
		glVertex2f(875, 325);
		glVertex2f(920, 325);

		glVertex2f(952.5, 345);
		glVertex2f(952.5, 305);
		glVertex2f(930, 325);
		glVertex2f(975, 325);
	}
	glEnd();

	// second row of side windows
	glColor3f(0.73, 0.87, 0.91);
	glBegin(GL_POLYGON);
	{
		glVertex2f(875, 295);
		glVertex2f(920, 295);
		glVertex2f(920, 255);
		glVertex2f(875, 255);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(930, 295);
		glVertex2f(975, 295);
		glVertex2f(975, 255);
		glVertex2f(930, 255);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(897.5, 295);
		glVertex2f(897.5, 255);
		glVertex2f(875, 275);
		glVertex2f(920, 275);

		glVertex2f(952.5, 295);
		glVertex2f(952.5, 255);
		glVertex2f(930, 275);
		glVertex2f(975, 275);
	}
	glEnd();

	// third row of side windows
	glColor3f(0.73, 0.87, 0.91);
	glBegin(GL_POLYGON);
	{
		glVertex2f(875, 245);
		glVertex2f(920, 245);
		glVertex2f(920, 205);
		glVertex2f(875, 205);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(930, 245);
		glVertex2f(975, 245);
		glVertex2f(975, 205);
		glVertex2f(930, 205);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(897.5, 255);
		glVertex2f(897.5, 205);
		glVertex2f(875, 225);
		glVertex2f(920, 225);

		glVertex2f(952.5, 255);
		glVertex2f(952.5, 205);
		glVertex2f(930, 225);
		glVertex2f(975, 225);
	}
	glEnd();

	// fourth row of side windows
	glColor3f(0.73, 0.87, 0.91);
	glBegin(GL_POLYGON);
	{
		glVertex2f(875, 195);
		glVertex2f(920, 195);
		glVertex2f(920, 155);
		glVertex2f(875, 155);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(930, 195);
		glVertex2f(975, 195);
		glVertex2f(975, 155);
		glVertex2f(930, 155);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(897.5, 195);
		glVertex2f(897.5, 155);
		glVertex2f(875, 175);
		glVertex2f(920, 175);

		glVertex2f(952.5, 195);
		glVertex2f(952.5, 155);
		glVertex2f(930, 175);
		glVertex2f(975, 175);
	}
	glEnd();

	// fifth row of side windows
	glColor3f(0.73, 0.87, 0.91);
	glBegin(GL_POLYGON);
	{
		glVertex2f(875, 145);
		glVertex2f(920, 145);
		glVertex2f(920, 105);
		glVertex2f(875, 105);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(930, 145);
		glVertex2f(975, 145);
		glVertex2f(975, 105);
		glVertex2f(930, 105);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(897.5, 155);
		glVertex2f(897.5, 105);
		glVertex2f(875, 125);
		glVertex2f(920, 125);

		glVertex2f(952.5, 155);
		glVertex2f(952.5, 105);
		glVertex2f(930, 125);
		glVertex2f(975, 125);
	}
	glEnd();

	// first row of front windows
	glColor3f(0.658824, 0.8, 0.843137);
	glBegin(GL_POLYGON);
	{
		glVertex2f(805, 360);
		glVertex2f(822.5, 355);
		glVertex2f(822.5, 310);
		glVertex2f(805, 315);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(827.5, 353.5);
		glVertex2f(845, 348.5);
		glVertex2f(845, 303.5);
		glVertex2f(827.5, 308.5);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(813.25, 358);
		glVertex2f(813.25, 310);
		glVertex2f(805, 338);
		glVertex2f(822.5, 333);

		glVertex2f(835.75, 351.5);
		glVertex2f(835.75, 303.5);
		glVertex2f(827.5, 331.5);
		glVertex2f(845, 326.5);
	}
	glEnd();

	// second row of front windows
	glColor3f(0.658824, 0.8, 0.843137);
	glBegin(GL_POLYGON);
	{
		glVertex2f(805, 310);
		glVertex2f(822.5, 305);
		glVertex2f(822.5, 260);
		glVertex2f(805, 265);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(827.5, 303.5);
		glVertex2f(845, 298.5);
		glVertex2f(845, 253.5);
		glVertex2f(827.5, 258.5);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(813.25, 308);
		glVertex2f(813.25, 260);
		glVertex2f(805, 288);
		glVertex2f(822.5, 283);

		glVertex2f(835.75, 301.5);
		glVertex2f(835.75, 253.5);
		glVertex2f(827.5, 281.5);
		glVertex2f(845, 276.5);
	}
	glEnd();

	// third row of front windows
	glColor3f(0.658824, 0.8, 0.843137);
	glBegin(GL_POLYGON);
	{
		glVertex2f(805, 260);
		glVertex2f(822.5, 255);
		glVertex2f(822.5, 210);
		glVertex2f(805, 215);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(827.5, 253.5);
		glVertex2f(845, 248.5);
		glVertex2f(845, 203.5);
		glVertex2f(827.5, 208.5);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(813.25, 258);
		glVertex2f(813.25, 210);
		glVertex2f(805, 238);
		glVertex2f(822.5, 233);

		glVertex2f(835.75, 251.5);
		glVertex2f(835.75, 203.5);
		glVertex2f(827.5, 231.5);
		glVertex2f(845, 226.5);
	}
	glEnd();

	// fourth row of front windows
	glColor3f(0.658824, 0.8, 0.843137);
	glBegin(GL_POLYGON);
	{
		glVertex2f(805, 210);
		glVertex2f(822.5, 205);
		glVertex2f(822.5, 160);
		glVertex2f(805, 165);
	}
	glEnd();

	glBegin(GL_POLYGON);
	{
		glVertex2f(827.5, 203.5);
		glVertex2f(845, 198.5);
		glVertex2f(845, 153.5);
		glVertex2f(827.5, 158.5);
	}
	glEnd();

	glColor3f(0.0, 0.0, 0.0);
	glBegin(GL_LINES);
	{
		glVertex2f(813.25, 208);
		glVertex2f(813.25, 160);
		glVertex2f(805, 188);
		glVertex2f(822.5, 183);

		glVertex2f(835.75, 201.5);
		glVertex2f(835.75, 153.5);
		glVertex2f(827.5, 181.5);
		glVertex2f(845, 176.5);
	}
	glEnd();

	// person (might want to thicken lines)
	// code for circle used from programanddesign.com/cpp/draw-an-unfilled-circle
	glColor3f(0.513725, 0.129412, 0.313725);
	glLineWidth(3);
	double inc = PI / 12;
	double max = 2 * PI;
	glBegin(GL_LINE_LOOP);
	for (double d = 0; d < max; d += inc)
		glVertex2f(cos(d) * 7 + 755, sin(d) * 7 + 90);
	glEnd();

	glBegin(GL_LINES);
	{
		// body
		glVertex2f(755, 83);
		glVertex2f(755, 70);

		// right arm
		glVertex2f(755, 75);
		glVertex2f(760, 80);

		// left arm
		glVertex2f(755, 75);
		glVertex2f(750, 80);

		// right leg
		glVertex2f(755, 70);
		glVertex2f(760, 60);

		// left leg
		glVertex2f(755, 70);
		glVertex2f(750, 60);
	}
	glEnd();
	
	if (!gameover)
	{
		glLineWidth(3);
		drawAttacker();
	}
	glLineWidth(1);
	if (energy)
		drawEnergy();
	if (x3 <= x2 && energy)
	{
		removeAttacker();
		removeEnergy();
	}
	if (gameover)
		removeAttacker();

	glFlush();
}

void idle()
{
	if (!paused)
	{
		if (x2 < 810 && !energy)
			x2 += speed;
		if (x2 >= 810)
		{
			speed = 0;
			x2 = 0;
			gameover = true;
			gameOver();
		}
		if (!attacker && !energy)
		{
			x2 = 0;
			x3 = 745;
			speed *= 2;
		}
		if (x3 > x2 && energy)
			x3 -= 0.5;
		glutPostRedisplay();
	}
}

void keyboard(unsigned char k, int x, int y)
{
	if (k == 'q' || k == 'Q')
		exit(0);
	else if (k == 'p' || k == 'P')
		paused = !paused;
	else if (k == 'b' || k == 'B')
	{
		if (!paused)
			energy = true;
	}
}

void reshape(int w, int h)
{
	glViewport(0, 0, w, h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0, float(w), 0, float(h));
}

int main(int argc, char* argv[])
{
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGB | GLUT_SINGLE);
	glutInitWindowSize(1100, 600);
	glutCreateWindow("The Beginning");
	init();
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutIdleFunc(idle);
	glutKeyboardFunc(keyboard);
	glutMainLoop();

	return 0;
}
